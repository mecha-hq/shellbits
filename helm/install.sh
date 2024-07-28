#!/bin/sh

set -e
set -o errexit -o nounset

CHART_PATH="${HELM_INSTALL_CHART_PATH:-.}"
RELEASE_NAME="${HELM_INSTALL_RELEASE_NAME:--$(basename $(pwd))}"
KUBE_CONFIG="${HELM_INSTALL_KUBE_CONFIG:${KUBECONFIG:-${HOME}/.kube/config}}"
KUBE_NAMESPACE="${HELM_INSTALL_KUBE_NAMESPACE:-default}"

helm upgrade \
    "${RELEASE_NAME}" "${CHART_PATH}" \
    --install \
    --debug \
    --kubeconfig=${KUBE_CONFIG} \
    --namespace=${KUBE_NAMESPACE} \
    --atomic
