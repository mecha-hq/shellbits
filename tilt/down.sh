#!/bin/sh

set -e
set -o errexit -o nounset

PROJECT_NAME="${1:-todo}"
FORCE="${FORCE:-0}"

echo "Deleting cluster..."
docker rm -f "${PROJECT_NAME}-control-plane"

if [ "${FORCE}" -eq "1" ]; then
  echo "Deleting local registry..."
  docker rm -f "${PROJECT_NAME}-registry"
else
  echo "Stopping local registry..."
  docker stop "${PROJECT_NAME}-registry"
fi

echo "Done."
