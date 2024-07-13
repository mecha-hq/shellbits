#!/bin/sh

set -e
set -o errexit -o nounset

PROJECT_NAME="${1:-todo}"

echo "Starting cluster and local registry..."

docker start "${PROJECT_NAME}-control-plane" "${PROJECT_NAME}-registry"

echo "Done."
