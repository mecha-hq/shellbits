#!/bin/sh

set -eu

# Public environment variables for mkfile lint command

# Export environment variables
export MKFILE_LINT_FLAGS="${MKFILE_LINT_FLAGS:- -c .rules/checkmake.ini}"
