#!/bin/sh

set -eu

# Public environment variables for jsonlint command

# Export environment variables
export JSONLINT_FLAGS="${JSONLINT_FLAGS:--c .rules/jsonlint.yaml}"