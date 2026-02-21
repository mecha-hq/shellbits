#!/bin/sh

set -e
set -u

# Public environment variables for yaml lint command

# Export environment variables
export YAML_LINT_ARGS="${YAML_LINT_ARGS:- -c .rules/yamllint.yaml}"
