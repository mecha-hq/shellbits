#!/bin/sh

set -eu

# Public environment variables for dockerfile linter command

# Export environment variables
export DOCKERFILE_LINT_FLAGS="${DOCKERFILE_LINT_FLAGS:--c .rules/hadolint.yaml}"
export DOCKERFILE_LINT_FIND_FLAGS="${DOCKERFILE_LINT_FIND_FLAGS:-}"