#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
ct lint \
    --charts "${HELM_LINT_CHARTS_PATH}" \
    --validate-maintainers="${HELM_LINT_VALIDATE_MAINTAINERS}" \
    --config "${HELM_LINT_CONFIG_PATH}"
