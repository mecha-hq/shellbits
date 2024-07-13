#!/bin/sh

set -e
set -o errexit -o nounset

PROJECT_NAME="${1:-todo}"

echo "Stopping cluster and local registry..."

docker stop "${PROJECT_NAME}-control-plane" "${PROJECT_NAME}-registry"

echo "Done."
