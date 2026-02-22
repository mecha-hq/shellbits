#!/bin/sh

set -eu

# Public environment variables for helm template command

# Export environment variables
export HELM_TEMPLATE_RELEASE_NAME="${HELM_TEMPLATE_RELEASE_NAME:-$(basename "$(pwd)")}"
export HELM_TEMPLATE_CHART_PATH="${HELM_TEMPLATE_CHART_PATH:-.}"
export HELM_TEMPLATE_FLAGS="${HELM_TEMPLATE_FLAGS:-}"
