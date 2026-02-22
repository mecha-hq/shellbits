#!/bin/sh

set -eu

# Public environment variables for file lint command

# Export environment variables
export FILE_LINT_FLAGS="${FILE_LINT_FLAGS:--c .rules/filelint.yaml}"