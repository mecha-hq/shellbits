#!/bin/sh

set -e
set -o errexit -o nounset

CHARTS_PATH="${HELM_LINT_CHARTS_PATH:-.}"
CONFIG_PATH="${HELM_LINT_CONFIG_PATH:-.rules/ct.yaml}"
VALIDATE_MAINTAINERS="${HELM_LINT_VALIDATE_MAINTAINERS:-false}"

ct lint \
	--charts "${CHARTS_PATH}" \
	--validate-maintainers="${VALIDATE_MAINTAINERS}" \
	--config "${CONFIG_PATH}"
