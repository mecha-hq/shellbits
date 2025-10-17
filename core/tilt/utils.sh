# Utilities

# Create the ctlptl registry (which is local registry used by Tilt) and the kind cluster.
function create {
  local KUBERNETES_MANIFESTS_DIR=${1:?Error: argument 1 must not be empty}

  echo "Creating cluster and local registry..."

  ctlptl apply -f "${KUBERNETES_MANIFESTS_DIR}/ctlptl-registry.yml"
  ctlptl apply -f "${KUBERNETES_MANIFESTS_DIR}/kind-config.yml"

  wait_for_container_ready "${PROJECT_NAME}-registry" 60 || return 1
  wait_for_container_ready "${PROJECT_NAME}-control-plane" 180 || return 1
  wait_for_kube_api "${PROJECT_NAME}" 60 || return 1

  disable_containers_restart
}

# Start the ctlptl registry (which is local registry used by Tilt) and the kind cluster.
function start {
  local PROJECT_NAME=${1:?Error: argument 1 must not be empty}

  echo "Starting cluster and local registry..."

  docker start "${PROJECT_NAME}-registry" "${PROJECT_NAME}-control-plane"

  wait_for_container_ready "${PROJECT_NAME}-registry" 60 || return 1
  wait_for_container_ready "${PROJECT_NAME}-control-plane" 180 || return 1
  wait_for_kube_api "${PROJECT_NAME}" 60 || return 1

  disable_containers_restart
}


# Create and inject self-signed TLS certificates into the cluster using mkcert.
# This is necessary for the ingress to work.
# Remember to add "0.0.0.0 ${PROJECT_DOMAIN}" line to your /etc/hosts file
function setup_certs {
  local MANIFESTS_DIR=${1:?Error: argument 1 must not be empty}
  local CERTS_DIR=${2:?Error: argument 2 must not be empty}
  local FORCE=${3:?Error: argument 3 must not be empty}

  mkdir -p "${CERTS_DIR}" "${MANIFESTS_DIR}"

  if [ "${FORCE}" -eq 1 ]; then
    if [ -f "${MANIFESTS_DIR}/${PROJECT_DOMAIN}-tls.yaml" ]; then
      rm -f "${MANIFESTS_DIR}/${PROJECT_DOMAIN}-tls.yaml"
    fi
  fi

  # setup self-signed tls certificates
  if [ ! -f "${MANIFESTS_DIR}/${PROJECT_DOMAIN}-tls.yaml" ]; then
    echo "Creating TLS certificate..."

    (cd "${CERTS_DIR}" && mkcert "*.${PROJECT_DOMAIN}" "${PROJECT_DOMAIN}" && mkcert -install) &&
      echo "Creating Kubernetes secret..."

      kubectl create secret tls "${PROJECT_DOMAIN}-tls" \
        --cert="${CERTS_DIR}/_wildcard.${PROJECT_DOMAIN}+1.pem" \
        --key="${CERTS_DIR}/_wildcard.${PROJECT_DOMAIN}+1-key.pem" \
        -o yaml --dry-run=client > "${MANIFESTS_DIR}/${PROJECT_DOMAIN}-tls.yaml"
  fi
}

function setup_kubeconfig {
  local PROJECT_NAME=${1:?Error: argument 1 must not be empty}
  local CONFIGS_DIR=${2:?Error: argument 2 must not be empty}

  echo "Setting up kubeconfig..."

  kind get kubeconfig --name "${PROJECT_NAME}" > "${CONFIGS_DIR}/kubeconfig"
  kubectl --kubeconfig "${CONFIGS_DIR}/kubeconfig" config set-context "${PROJECT_NAME}"

  export KUBECONFIG="${CONFIGS_DIR}/kubeconfig"
}

function setup_tiltfiles {
  local TILTFILES_DIR=${1:?Error: argument 1 must not be empty}

  echo "Setting up tiltfiles..."

  mkdir -p "${TILTFILES_DIR}"

  cat "${SCRIPT_DIR}/files/setup.tiltfile.tpl" | envsubst > "${TILTFILES_DIR}/setup.tiltfile"
}

# Wait until the container is running and, if a Docker healthcheck exists, reports healthy.
function wait_for_container_ready {
  local CONTAINER_NAME=${1:?Error: argument 1 must not be empty}
  local TIMEOUT=${2:-60}
  local INTERVAL=1
  local ELAPSED=0

  printf 'Waiting for %s to be ready... ' "${CONTAINER_NAME}"

  while [ "${ELAPSED}" -lt "${TIMEOUT}" ]; do
    INSPECT_OUTPUT=$(docker inspect --format '{{.State.Status}}:{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "${CONTAINER_NAME}" 2>/dev/null)
    INSPECT_EXIT=$?

    if [ "${INSPECT_EXIT}" -eq 0 ] && [ -n "${INSPECT_OUTPUT}" ]; then
      STATUS=${INSPECT_OUTPUT%%:*}
      HEALTH=${INSPECT_OUTPUT#*:}

      if [ "${STATUS}" = "${INSPECT_OUTPUT}" ]; then
        HEALTH=none
      fi

      if [ "${STATUS}" = "running" ]; then
        if [ "${HEALTH}" = "healthy" ] || [ "${HEALTH}" = "none" ]; then
          printf 'READY\n' "${CONTAINER_NAME}"
          return 0
        fi
      fi
    fi

    sleep "${INTERVAL}"
    ELAPSED=$((ELAPSED + INTERVAL))
  done

  printf 'FAIL\n' >&2
  return 1
}

# Wait until the kubernetes api is responding with a success message.
function wait_for_kube_api {
  local CLUSTER_NAME=${1:?Error: argument 1 must not be empty}
  local TIMEOUT=${2:-60}
  local INTERVAL=1
  local ELAPSED=0
  local PORT="$(kind get kubeconfig --name ${CLUSTER_NAME} | yq '.clusters[0].cluster.server' | cut -d ':' -f 3)"

  printf 'Waiting for Kubernetes API to return 200... '

  while [ "${ELAPSED}" -lt "${TIMEOUT}" ]; do
    HTTP_CODE=$(curl -ks -o /dev/null -w "%{http_code}" "https://127.0.0.1:${PORT}/version?timeout=32s" || true)
    if [ "${HTTP_CODE}" = "200" ]; then
      printf 'READY\n'
      return 0
    fi

    sleep "${INTERVAL}"
    ELAPSED=$((ELAPSED + INTERVAL))
  done

  printf 'FAIL\n' >&2
  return 1
}

# Disable automatic restart of the cluster and the registry
function disable_containers_restart {
  docker update --restart=no "${PROJECT_NAME}-registry" "${PROJECT_NAME}-control-plane"
}
