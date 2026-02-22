#!/bin/sh

set -eu

# Public environment variables for yaml lint command

# Export environment variables
export YAML_LINT_FLAGS="${YAML_LINT_FLAGS:- -c .rules/yamllint.yaml}"
