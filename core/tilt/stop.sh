#!/bin/sh

set -e
set -o errexit -o nounset

# Variables

PROJECT_NAME="${TILT_STOP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Exec

echo "Stopping cluster and local registry..."

docker stop "${PROJECT_NAME}-control-plane" "${PROJECT_NAME}-registry"

echo "Done."
