#!/bin/sh

set -e
set -u

# Public environment variables for shell lint command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export SHELL_LINT_ARGS="${SHELL_LINT_ARGS:- -a -o all -s bash}"
