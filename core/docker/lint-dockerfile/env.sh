#!/bin/sh

set -eu

# Public environment variables for docker lint-dockerfile command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export DOCKER_LINT_DOCKERFILE_FIND_FLAGS="${DOCKER_LINT_DOCKERFILE_FIND_FLAGS:-}"
