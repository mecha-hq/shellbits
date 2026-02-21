#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Parse arguments
_image_name="${1:?Error: IMAGE_NAME argument is required}"
_image_tag="${2:-${COSIGN_TEST_SIGN_IMAGE_TAG:-latest}}"
_cosign_env_var="${3:-${COSIGN_TEST_SIGN_COSIGN_ENV_VAR:-COSIGN_KEY}}"

# Sign the image
echo "Signing image ${_image_name}:${_image_tag}"
_image_id=$(docker inspect "${_image_name}:${_image_tag}" | jq -r '.[0].Id')
cosign sign --key="env://${_cosign_env_var}" --upload=false --yes "${_image_name}@${_image_id}"

echo "Image signed successfully"
