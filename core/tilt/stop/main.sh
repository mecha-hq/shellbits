#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# Source environment variables FIRST
. "${_script_dir}/env.sh"
# THEN set private variables using the now-loaded env vars
_project_name="${TILT_STOP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Exec

echo "Stopping cluster and local registry..."

docker stop "${_project_name}-control-plane" "${_project_name}-registry"

echo "Done."
