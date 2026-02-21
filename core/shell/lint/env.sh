#!/bin/sh

set -eu

# Public environment variables for shell lint command

# Export environment variables
export SHELL_LINT_ARGS="${SHELL_LINT_ARGS:- -a -o all -s sh --source-path=SCRIPTDIR -x}"
