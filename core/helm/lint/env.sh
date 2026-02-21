#!/bin/sh

set -e
set -u

# Public environment variables for helm lint command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export HELM_LINT_CHARTS_PATH="${HELM_LINT_CHARTS_PATH:-.}"
export HELM_LINT_CONFIG_PATH="${HELM_LINT_CONFIG_PATH:-.rules/ct.yaml}"
export HELM_LINT_VALIDATE_MAINTAINERS="${HELM_LINT_VALIDATE_MAINTAINERS:-false}"
