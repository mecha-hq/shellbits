#!/bin/sh

set -eu

# Public environment variables for makefile lint command

# Export environment variables
export MAKEFILE_LINT_FLAGS="${MAKEFILE_LINT_FLAGS:--c .rules/checkmake.yaml}"