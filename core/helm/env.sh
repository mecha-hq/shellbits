#!/bin/sh

set -e
set -u

# Common public environment variables for helm scripts

# Export environment variables
export HELM_CONFIG_HOME="${HELM_CONFIG_HOME:-${HOME}/.config/helm}"
export HELM_CACHE_HOME="${HELM_CACHE_HOME:-${HOME}/.cache/helm}"
export HELM_DATA_HOME="${HELM_DATA_HOME:-${HOME}/.local/share/helm}"
export HELM_REGISTRY_CONFIG="${HELM_REGISTRY_CONFIG:-${HOME}/.config/helm/registry.json}"
