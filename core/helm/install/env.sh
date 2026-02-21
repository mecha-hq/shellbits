#!/bin/sh

set -eu

# Public environment variables for helm install command

# Export environment variables
export HELM_INSTALL_CHART_PATH="${HELM_INSTALL_CHART_PATH:-.}"
export HELM_INSTALL_RELEASE_NAME="${HELM_INSTALL_RELEASE_NAME:-$(basename "$(pwd)")}"
export HELM_INSTALL_KUBE_CONFIG="${HELM_INSTALL_KUBE_CONFIG:-${KUBECONFIG:-${HOME}/.kube/config}}"
export HELM_INSTALL_KUBE_NAMESPACE="${HELM_INSTALL_KUBE_NAMESPACE:-default}"
export HELM_INSTALL_FLAGS="${HELM_INSTALL_FLAGS:-}"
