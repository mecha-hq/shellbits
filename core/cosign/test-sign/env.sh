#!/bin/sh

set -eu

# Public environment variables for cosign test-sign command

# Export environment variables
export COSIGN_TEST_SIGN_IMAGE_TAG="${COSIGN_TEST_SIGN_IMAGE_TAG:-latest}"
export COSIGN_TEST_SIGN_COSIGN_ENV_VAR="${COSIGN_TEST_SIGN_COSIGN_ENV_VAR:-COSIGN_KEY}"
