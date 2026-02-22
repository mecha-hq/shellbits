#!/bin/sh

set -eu

# Public environment variables for shfmt format command

# Export environment variables
export SHFMT_FORMAT_FLAGS="${SHFMT_FORMAT_FLAGS:--w -i 2 -ci -sr}"