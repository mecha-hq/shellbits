#!/bin/sh

set -eu

# Public environment variables for hadolint lint command

# Export environment variables
export HADOLINT_LINT_FLAGS="${HADOLINT_LINT_FLAGS:---no-color}"
