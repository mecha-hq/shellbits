#!/bin/sh

set -eu

# Public environment variables for helm lint command

# Export environment variables
export HELM_LINT_CHARTS_PATH="${HELM_LINT_CHARTS_PATH:-.}"
export HELM_LINT_CONFIG_PATH="${HELM_LINT_CONFIG_PATH:-.rules/ct.yaml}"
export HELM_LINT_VALIDATE_MAINTAINERS="${HELM_LINT_VALIDATE_MAINTAINERS:-false}"
export HELM_LINT_FLAGS="${HELM_LINT_FLAGS:-}"
