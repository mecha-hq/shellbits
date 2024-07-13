#!/bin/sh

# NOTE: this script only works with cosign 2

set -e
set -o errexit -o nounset

IMAGE_NAME="${1}"
IMAGE_TAG="${2:-latest}"
COSIGN_ENV_VAR="${3:-COSIGN_KEY}"

echo "Signing image"
IMAGE_ID=$(docker inspect ${IMAGE_NAME}:${IMAGE_TAG} | jq -r '.[0].Id')
cosign sign --key="env://${COSIGN_ENV_VAR}" --upload=false --yes "${IMAGE_NAME}@${IMAGE_ID}"
