#!/bin/sh

# Public environment variables for tilt up command

# Source common environment variables
. "${_script_dir}/../env.sh"

# TILT_UP_PROJECT_NAME: Project name override for up command
TILT_UP_PROJECT_NAME="${TILT_UP_PROJECT_NAME:-${TILT_PROJECT_NAME}}"

# TILT_UP_PROJECT_DOMAIN: Project domain (default: <project_name>.dev)
TILT_UP_PROJECT_DOMAIN="${TILT_UP_PROJECT_DOMAIN:-}"

# TILT_UP_FORCE: Force flag for up command (default: 0)
TILT_UP_FORCE="${TILT_UP_FORCE:-${TILT_FORCE:-0}}"

# TILT_UP_SETUP_TLS_CERTS: Setup TLS certificates (default: 1)
TILT_UP_SETUP_TLS_CERTS="${TILT_UP_SETUP_TLS_CERTS:-1}"

# TILT_UP_WORKING_DIR: Working directory (default: current directory)
TILT_UP_WORKING_DIR="${TILT_UP_WORKING_DIR:-$(pwd)}"

# TILT_UP_CONFIGS_DIR: Configs directory (default: <working_dir>/configs)
TILT_UP_CONFIGS_DIR="${TILT_UP_CONFIGS_DIR:-${TILT_UP_WORKING_DIR}/configs}"

# TILT_UP_KUBERNETES_MANIFESTS_DIR: Kubernetes manifests directory
# (default: <configs_dir>/kubernetes-manifests)
TILT_UP_KUBERNETES_MANIFESTS_DIR="${TILT_UP_KUBERNETES_MANIFESTS_DIR:-${TILT_UP_CONFIGS_DIR}/kubernetes-manifests}"

# TILT_UP_TILTFILE_PATH: Tiltfile path (default: <working_dir>/Tiltfile)
TILT_UP_TILTFILE_PATH="${TILT_UP_TILTFILE_PATH:-${TILT_UP_WORKING_DIR}/Tiltfile}"

# TILT_UP_TLS_MANIFEST_PATH: TLS manifest path
# (default: <kubernetes_manifests_dir>/titan.dev-tls.yaml)
TILT_UP_TLS_MANIFEST_PATH="${TILT_UP_TLS_MANIFEST_PATH:-${TILT_UP_KUBERNETES_MANIFESTS_DIR}/titan.dev-tls.yaml}"
