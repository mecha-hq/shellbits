# Utilities

# Create the ctlptl registry (which is local registry used by Tilt) and the kind cluster.
create() {
  _kubernetes_manifests_dir=${1:?Error: argument 1 must not be empty}

  echo "Creating cluster and local registry..."

  ctlptl apply -f "${_kubernetes_manifests_dir}/ctlptl-registry.yml"
  ctlptl apply -f "${_kubernetes_manifests_dir}/kind-config.yml"

  wait_for_container_ready "${_project_name}-registry" 60 || return 1
  wait_for_container_ready "${_project_name}-control-plane" 180 || return 1
  wait_for_kube_api "${_project_name}" 60 || return 1

  disable_containers_restart "${_project_name}"
}

# Start the ctlptl registry (which is local registry used by Tilt) and the kind cluster.
start() {
  _project_name=${1:?Error: argument 1 must not be empty}

  echo "Starting cluster and local registry..."

  docker start "${_project_name}-registry" "${_project_name}-control-plane"

  wait_for_container_ready "${_project_name}-registry" 60 || return 1
  wait_for_container_ready "${_project_name}-control-plane" 180 || return 1
  wait_for_kube_api "${_project_name}" 60 || return 1

  disable_containers_restart "${_project_name}"
}


# Create and inject self-signed TLS certificates into the cluster using mkcert.
# This is necessary for the ingress to work.
# Remember to add "0.0.0.0 ${_project_domain}" line to your /etc/hosts file
setup_certs() {
  _project_domain=${1:?Error: argument 1 must not be empty}
  _manifests_dir=${2:?Error: argument 2 must not be empty}
  _certs_dir=${3:?Error: argument 3 must not be empty}
  _force=${4:?Error: argument 4 must not be empty}

  mkdir -p "${_certs_dir}" "${_manifests_dir}"

  if [ "${_force}" -eq 1 ]; then
    if [ -f "${_manifests_dir}/${_project_domain}-tls.yaml" ]; then
      rm -f "${_manifests_dir}/${_project_domain}-tls.yaml"
    fi
  fi

  # setup self-signed tls certificates
  if [ ! -f "${_manifests_dir}/${_project_domain}-tls.yaml" ]; then
    echo "Creating TLS certificate..."

    (cd "${_certs_dir}" && mkcert "*.${_project_domain}" "${_project_domain}" && mkcert -install) &&
      echo "Creating Kubernetes secret..."

      kubectl create secret tls "${_project_domain}-tls" \
        --cert="${_certs_dir}/_wildcard.${_project_domain}+1.pem" \
        --key="${_certs_dir}/_wildcard.${_project_domain}+1-key.pem" \
        -o yaml --dry-run=client > "${_manifests_dir}/${_project_domain}-tls.yaml"
  fi
}

setup_kubeconfig() {
  _project_name=${1:?Error: argument 1 must not be empty}
  _configs_dir=${2:?Error: argument 2 must not be empty}

  echo "Setting up kubeconfig..."

  kind get kubeconfig --name "${_project_name}" > "${_configs_dir}/kubeconfig"
  kubectl --kubeconfig "${_configs_dir}/kubeconfig" config set-context "${_project_name}"

  export KUBECONFIG="${_configs_dir}/kubeconfig"
}

setup_tiltfiles() {
  _tiltfiles_dir=${1:?Error: argument 1 must not be empty}
  _script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

  echo "Setting up tiltfiles..."

  mkdir -p "${_tiltfiles_dir}"

  envsubst < "${_script_dir}/files/setup.tiltfile.tpl" > "${_tiltfiles_dir}/setup.tiltfile"

}

# Wait until the container is running and, if a Docker healthcheck exists, reports healthy.
wait_for_container_ready() {
  _container_name=${1:?Error: argument 1 must not be empty}
  _timeout=${2:-60}
  _interval=1
  _elapsed=0

  printf 'Waiting for %s to be ready... ' "${_container_name}"

  while [ "${_elapsed}" -lt "${_timeout}" ]; do
    _inspect_output=$(docker inspect --format '{{.State.Status}}:{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "${_container_name}" 2>/dev/null)
    _inspect_exit=$?

    if [ "${_inspect_exit}" -eq 0 ] && [ -n "${_inspect_output}" ]; then
      _status=${_inspect_output%%:*}
      _health=${_inspect_output#*:}

      if [ "${_status}" = "${_inspect_output}" ]; then
        _health=none
      fi

      if [ "${_status}" = "running" ]; then
        if [ "${_health}" = "healthy" ] || [ "${_health}" = "none" ]; then
          printf 'READY\n'
          return 0
        fi
      fi
    fi

    sleep "${_interval}"

    _elapsed=$((_elapsed + _interval))
  done

  printf 'FAIL\n' >&2
  return 1
}

# Wait until the kubernetes api is responding with a success message.
wait_for_kube_api() {
  _cluster_name=${1:?Error: argument 1 must not be empty}
  _timeout=${2:-60}
  _interval=1
  _elapsed=0
  _port="$(kind get kubeconfig --name "${_cluster_name}" | yq '.clusters[0].cluster.server' | cut -d ':' -f 3)"

  printf 'Waiting for Kubernetes API to return 200... '

  while [ "${_elapsed}" -lt "${_timeout}" ]; do
    _http_code=$(curl -ks -o /dev/null -w "%{http_code}" "https://127.0.0.1:${_port}/version?timeout=32s" || true)
    if [ "${_http_code}" = "200" ]; then
      printf 'READY\n'
      return 0
    fi

    sleep "${_interval}"

    _elapsed=$((_elapsed + _interval))
  done

  printf 'FAIL\n' >&2
  return 1
}

# Disable automatic restart of the cluster and the registry
disable_containers_restart() {
  _project_name=${1:?Error: argument 1 must not be empty}

  docker update --restart=no "${_project_name}-registry" "${_project_name}-control-plane"
}
