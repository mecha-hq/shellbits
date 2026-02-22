#!/bin/sh

set -eu

# Public environment variables for yamllint command

# Export environment variables
export YAMLLINT_FLAGS="${YAMLLINT_FLAGS:--c .rules/yamllint.yaml}"