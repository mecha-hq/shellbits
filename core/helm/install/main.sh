#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
helm upgrade \
    "${HELM_INSTALL_RELEASE_NAME}" "${HELM_INSTALL_CHART_PATH}" \
    --kubeconfig="${HELM_INSTALL_KUBE_CONFIG}" \
    --namespace="${HELM_INSTALL_KUBE_NAMESPACE}" \
    --atomic \
    --debug \
    --install \
    "${HELM_INSTALL_FLAGS}"
