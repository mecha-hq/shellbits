#!/bin/sh

set -eu

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables

. "${_script_dir}/env.sh"

# Exec

echo "Stopping cluster and local registry..."

docker stop "${TILT_STOP_PROJECT_NAME}-control-plane" "${TILT_STOP_PROJECT_NAME}-registry"

echo "Done."
