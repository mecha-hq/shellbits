#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
_project_name="${TILT_UP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"
_project_domain="${TILT_UP_PROJECT_DOMAIN:-${_project_name}.dev}"
_force="${TILT_UP_FORCE:-${TILT_FORCE:-0}}"
_setup_tls_certs="${TILT_UP_SETUP_TLS_CERTS:-1}"
_working_dir=${TILT_UP_WORKING_DIR:-$(pwd)}
_configs_dir=${TILT_UP_CONFIGS_DIR:-"${_working_dir}/configs"}
_kubernetes_manifests_dir=${TILT_UP_KUBERNETES_MANIFESTS_DIR:-"${_configs_dir}/kubernetes-manifests"}
_tiltfile_path=${TILT_UP_TILTFILE_PATH:-"${_working_dir}/Tiltfile"}
_tls_manifest_path=${TILT_UP_TLS_MANIFEST_PATH:-"${_kubernetes_manifests_dir}/titan.dev-tls.yaml"}

# Parse flags

while :; do
    case ${1:-} in
        -f|--force)
            _force=1
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

. "${_script_dir}/utils.sh"

# Setup

if [ "${_setup_tls_certs:-0}" -eq 1 ]; then
    # Setup self-signed TLS certificates for the ingress to work.
    # It installs the CA certificate to your browser's trusted certificates.
    # Remember to add 0.0.0.0 ${_project_domain} line to your /etc/hosts file.
    setup_certs "${_kubernetes_manifests_dir}" "${_configs_dir}/certs" "${_force}"
fi

# Exec

if docker inspect "${_project_name}-registry" >/dev/null 2>&1 &&
   docker inspect "${_project_name}-control-plane" >/dev/null 2>&1; then
    start "${_project_name}"
else
    create "${_kubernetes_manifests_dir}"
fi

setup_kubeconfig "${_project_name}" "${_configs_dir}"
setup_tiltfiles "${_configs_dir}/tiltfiles"

echo "Starting Tilt's dev environment..."

tilt up -d -v -f "${_tiltfile_path}"

echo "Done."
