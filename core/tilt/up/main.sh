#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables

. "${_script_dir}/env.sh"

# Parse flags

while :; do
    case ${1:-} in
        -f|--force)
            TILT_UP_FORCE=1
            ;;
        --) # End of all options.
            shift
            break
            ;;
        *)  # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

# Load utils

. "${_script_dir}/../utils.sh"

# Setup

if [ "${TILT_UP_SETUP_TLS_CERTS}" -eq 1 ]; then
    # Setup self-signed TLS certificates for the ingress to work.
    # It installs the CA certificate to your browser's trusted certificates.
    # Remember to add 0.0.0.0 ${TILT_UP_PROJECT_NAME} line to your /etc/hosts file.
    setup_certs "${TILT_UP_KUBERNETES_MANIFESTS_DIR}" "${TILT_UP_CONFIGS_DIR}/certs" "${TILT_UP_FORCE}"
fi

# Exec

if docker inspect "${TILT_UP_PROJECT_NAME}-registry" >/dev/null 2>&1 &&
   docker inspect "${TILT_UP_PROJECT_NAME}-control-plane" >/dev/null 2>&1; then
    start "${TILT_UP_PROJECT_NAME}"
else
    create "${TILT_UP_KUBERNETES_MANIFESTS_DIR}"
fi

setup_kubeconfig "${TILT_UP_PROJECT_NAME}" "${TILT_UP_CONFIGS_DIR}"
setup_tiltfiles "${TILT_UP_CONFIGS_DIR}/tiltfiles"

echo "Starting Tilt's dev environment..."

tilt up -d -v -f "${TILT_UP_TILTFILE_PATH}"

echo "Done."
