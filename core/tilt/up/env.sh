#!/bin/sh

# Public environment variables for tilt up command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export TILT_UP_PROJECT_NAME="${TILT_UP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"
export TILT_UP_PROJECT_DOMAIN="${TILT_UP_PROJECT_DOMAIN:-${TILT_UP_PROJECT_NAME}.dev}"
export TILT_UP_FORCE="${TILT_UP_FORCE:-${TILT_FORCE:-0}}"
export TILT_UP_SETUP_TLS_CERTS="${TILT_UP_SETUP_TLS_CERTS:-0}"
export TILT_UP_WORKING_DIR="${TILT_UP_WORKING_DIR:-$(pwd)}"
export TILT_UP_CONFIGS_DIR="${TILT_UP_CONFIGS_DIR:-${TILT_UP_WORKING_DIR}/configs}"
export TILT_UP_KUBERNETES_MANIFESTS_DIR="${TILT_UP_KUBERNETES_MANIFESTS_DIR:-${TILT_UP_CONFIGS_DIR}/kubernetes-manifests}"
export TILT_UP_TILTFILE_PATH="${TILT_UP_TILTFILE_PATH:-${TILT_UP_WORKING_DIR}/Tiltfile}"
export TILT_UP_TLS_MANIFEST_PATH="${TILT_UP_TLS_MANIFEST_PATH:-${TILT_UP_KUBERNETES_MANIFESTS_DIR}/${TILT_UP_PROJECT_DOMAIN}-tls.yaml}" # TODO: looks unused, check if it can be removed
