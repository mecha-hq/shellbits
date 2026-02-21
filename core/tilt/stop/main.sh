#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Cleanup function to unset all environment variables
cleanup_env() {
    # Common variables
    unset TILT_PROJECT_NAME
    unset TILT_FORCE
    # Stop-specific variables
    unset TILT_STOP_PROJECT_NAME
}

# Set trap to cleanup on script exit
trap cleanup_env EXIT

# Source environment variables
. "${_script_dir}/env.sh"

# Set private variables using the now-loaded env vars
_project_name="${TILT_STOP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Exec

echo "Stopping cluster and local registry..."

docker stop "${_project_name}-control-plane" "${_project_name}-registry"

echo "Done."
