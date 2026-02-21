#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
yamllint ${YAML_LINT_FLAGS} .
