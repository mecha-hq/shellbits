#!/bin/sh

set -eu

# Public environment variables for shell format command

# Export environment variables
export SHELL_FORMAT_FLAGS="${SHELL_FORMAT_FLAGS:--i 2 -ci -sr -w}"
