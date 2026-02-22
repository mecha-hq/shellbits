#!/bin/sh

set -eu

# Public environment variables for docker lint-dockerfile command

# Export environment variables
export DOCKER_LINT_DOCKERFILE_FIND_FLAGS="${DOCKER_LINT_DOCKERFILE_FIND_FLAGS:-}"
