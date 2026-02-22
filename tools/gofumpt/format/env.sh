#!/bin/sh

set -eu

# Public environment variables for gofumpt format command

# Export environment variables
export GOFUMPT_FORMAT_FLAGS="${GOFUMPT_FORMAT_FLAGS:--w -extra}"