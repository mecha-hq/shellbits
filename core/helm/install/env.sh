#!/bin/sh

set -e
set -u

# Public environment variables for helm install command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export HELM_INSTALL_CHART_PATH="${HELM_INSTALL_CHART_PATH:-.}"
export HELM_INSTALL_RELEASE_NAME="${HELM_INSTALL_RELEASE_NAME:--$(basename "$(pwd)")}"
export HELM_INSTALL_KUBE_CONFIG="${HELM_INSTALL_KUBE_CONFIG:-${KUBECONFIG:-${HOME}/.kube/config}}"
export HELM_INSTALL_KUBE_NAMESPACE="${HELM_INSTALL_KUBE_NAMESPACE:-default}"
