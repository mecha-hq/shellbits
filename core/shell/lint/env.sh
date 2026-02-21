#!/bin/sh

set -eu

# Public environment variables for shell lint command

# Export environment variables
export SHELL_LINT_FLAGS="${SHELL_LINT_FLAGS:- -a -o all -s sh --source-path=SCRIPTDIR -x}"
