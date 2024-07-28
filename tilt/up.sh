#!/bin/sh

set -e
set -o errexit -o nounset

# Variables

PROJECT_NAME="${TILT_UP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"
PROJECT_DOMAIN="${TILT_UP_PROJECT_DOMAIN:-${PROJECT_NAME}.dev}"
FORCE="${TILT_UP_FORCE:-${TILT_FORCE:-0}}"
SETUP_TLS_CERTS="${TILT_UP_SETUP_TLS_CERTS:-1}"
WORKING_DIR=${TILT_UP_WORKING_DIR:-$(pwd)}
CONFIGS_DIR=${TILT_UP_CONFIGS_DIR:-"${WORKING_DIR}/hack/develop"}
SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Parse flags

while :; do
    case ${1:-} in
        -f|--force)
            FORCE=1
            ;;
        --)                       # End of all options.
            shift
            break
            ;;
        *)                        # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

# Load utils

source "${SCRIPT_DIR}/utils.sh"

# Validate

if [[ -z "${TILT_FILES_SETUP_ALLOW_K8S_CONTEXTS}" ]]; then
    echo "TILT_FILES_SETUP_ALLOW_K8S_CONTEXTS is not set, please set it using the name of the kubernetes context(s) you want to use."
    exit 1
fi

if [[ -z "${TILT_FILES_SETUP_NAMESPACE}" ]]; then
    echo "TILT_FILES_SETUP_NAMESPACE is not set, please set it using the name of the kubernetes namespace you want to use."
    exit 1
fi

# Setup

if [[ ${SETUP_TLS_CERTS} -eq 1 ]]; then
    if [[ -z "${TILT_FILES_SETUP_TLS_MANIFEST_PATH}" ]]; then
        echo "TILT_FILES_SETUP_TLS_MANIFEST_PATH is not set, please set it using the path to the tls manifest file."
        exit 1
    fi

    # Setup self-signed TLS certificates for the ingress to work.
    # It installs the CA certificate to your browser's trusted certificates.
    # Remember to add 0.0.0.0 ${PROJECT_DOMAIN} line to your /etc/hosts file.
    setup_certs "${CONFIGS_DIR}/kubernetes-manifests" "${CONFIGS_DIR}/certs" "${FORCE}"
fi

# Exec

if [[ -n $(docker ps -q -a -f name="${PROJECT_NAME}-registry" || true) ]] &&
    [[ -n $(docker ps -q -a -f name="${PROJECT_NAME}-control-plane" || true) ]]; then
    start "${PROJECT_NAME}"
else
    create "${CONFIGS_DIR}/kubernetes-manifests"
fi

setup_kubeconfig "${PROJECT_NAME}" "${CONFIGS_DIR}"
setup_tiltfiles "${CONFIGS_DIR}/tiltfiles"

echo "Starting Tilt's dev environment..."

tilt up -f "${CONFIGS_DIR}/Tiltfile"

echo "Done."
