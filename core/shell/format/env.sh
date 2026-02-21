#!/bin/sh

set -e
set -u

# Public environment variables for shell format command

# Export environment variables
export SHELL_FORMAT_ARGS="${SHELL_FORMAT_ARGS:--i 2 -ci -sr -w}"
