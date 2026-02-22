#!/bin/sh

set -eu

# Public environment variables for go fmt command

# Export environment variables
export GO_FMT_FLAGS="${GO_FMT_FLAGS:--w -s}"