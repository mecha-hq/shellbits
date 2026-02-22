#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec - use consolidated dockerfile linter tool
echo "Linting Dockerfiles..."
${SHELLBITS_DIR}/tools/linter-dockerfile/lint/main.sh