#!/bin/sh

set -e
set -u

# Public environment variables for shell format command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export SHELL_FORMAT_ARGS="${SHELL_FORMAT_ARGS:--i 2 -ci -sr -w}"
