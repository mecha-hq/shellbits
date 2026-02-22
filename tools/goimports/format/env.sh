#!/bin/sh

set -eu

# Public environment variables for goimports format command

# Export environment variables
export GOIMPORTS_FORMAT_FLAGS="${GOIMPORTS_FORMAT_FLAGS:--w -e}"
export GOIMPORTS_FORMAT_PREFIX="${GOIMPORTS_FORMAT_PREFIX:-github.com/mecha-hq}"