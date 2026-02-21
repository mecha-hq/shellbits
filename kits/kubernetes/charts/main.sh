#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec

helm template "${HELM_TEMPLATE_RELEASE_NAME}" "${HELM_TEMPLATE_CHART_PATH}" \
    --atomic \
    --create-namespace \
    --dry-run \
    --debug \
    "${HELM_TEMPLATE_FLAGS}"
