#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

echo "Running golangci-lint..."
golangci-lint ${GOLANGCI_LINT_FLAGS} --config="${GOLANGCI_LINT_CONFIG}" ./...