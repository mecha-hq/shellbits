# Utilities

# This function will create the ctlptl registry (which is local registry used by Tilt) and the kind cluster.
function create {
  local KUBERNETES_MANIFESTS_DIR=${1}

  echo "Creating cluster and local registry..."

  ctlptl apply -f "${KUBERNETES_MANIFESTS_DIR}/ctlptl-registry.yml"
  ctlptl apply -f "${KUBERNETES_MANIFESTS_DIR}/kind-config.yml"

  # Disable automatic restart of the cluster and the registry
  docker update --restart=no "${PROJECT_NAME}-control-plane" "${PROJECT_NAME}-registry"
}

# This function will create and inject self-signed TLS certificates into the cluster, using mkcert(it install the CA certificate to your browser's trusted certificates). This is necessary for the ingress to work.
# Remember to add "0.0.0.0 ${PROJECT_DOMAIN}" line to your /etc/hosts file
function setup_certs {
  local MANIFESTS_DIR=$1
  local CERTS_DIR=$2
  local FORCE=$3

  mkdir -p "${CERTS_DIR}" "${MANIFESTS_DIR}"

  if [[ "${FORCE}" -eq 1 ]]; then
    if [[ -f "${MANIFESTS_DIR}/${PROJECT_DOMAIN}-tls.yaml" ]]; then
      rm -f "${MANIFESTS_DIR}/${PROJECT_DOMAIN}-tls.yaml"
    fi
  fi

  # setup self-signed tls certificates
  if [[ ! -f "${MANIFESTS_DIR}/${PROJECT_DOMAIN}-tls.yaml" ]]; then
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
  local PROJECT_NAME=$1
  local CONFIGS_DIR=$2

  echo "Setting up kubeconfig..."

  kind get kubeconfig --name "${PROJECT_NAME}" > "${CONFIGS_DIR}/kubeconfig"
  kubectl --kubeconfig "${CONFIGS_DIR}/kubeconfig" config set-context "${PROJECT_NAME}"

  export KUBECONFIG="${CONFIGS_DIR}/kubeconfig"
}

function setup_tiltfiles {
  local TILTFILES_DIR=$1

  echo "Setting up tiltfiles..."

  mkdir -p "${TILTFILES_DIR}"

  cat "${SCRIPT_DIR}/files/setup.tiltfile.tpl" | envsubst > "${TILTFILES_DIR}/setup.tiltfile"
}

# Waits until the container is running and, if a Docker healthcheck exists, reports healthy.
function wait_for_container_ready {
  local CONTAINER_NAME=$1
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

function wait_for_kube_api {
  local TIMEOUT=${1:-60}
  local INTERVAL=1
  local ELAPSED=0

  printf 'Waiting for Kubernetes API to return 200... '

  while [ "${ELAPSED}" -lt "${TIMEOUT}" ]; do
    HTTP_CODE=$(curl -ks -o /dev/null -w "%{http_code}" "https://127.0.0.1:36579/version?timeout=32s" || true)
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

# This function will start the ctlptl registry (which is local registry used by Tilt) and the kind cluster.
function start {
  local PROJECT_NAME=$1

  echo "Starting cluster and local registry..."

  docker start "${PROJECT_NAME}-registry" "${PROJECT_NAME}-control-plane"

  wait_for_container_ready "${PROJECT_NAME}-registry" 60 || return 1
  wait_for_container_ready "${PROJECT_NAME}-control-plane" 180 || return 1
  wait_for_kube_api 60 || return 1

  # disable automatic restart of the cluster and the registry
  docker update --restart=no "${PROJECT_NAME}-registry" "${PROJECT_NAME}-control-plane"
}
