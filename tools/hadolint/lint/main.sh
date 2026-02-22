#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

find . -type f -name "Dockerfile*" -exec hadolint "${HADOLINT_LINT_FLAGS}" {} \;
