#!/bin/sh

set -e
set -o errexit -o nounset

# Variables

_project_name="${TILT_STOP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Exec

echo "Stopping cluster and local registry..."

docker stop "${_project_name}-control-plane" "${_project_name}-registry"

echo "Done."
