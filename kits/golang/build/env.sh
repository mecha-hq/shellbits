#!/bin/sh

set -eu

# Public environment variables for goreleaser build command

# Export environment variables
export GORELEASER_BUILD_FLAGS="${GORELEASER_BUILD_FLAGS:---debug --snapshot --clean}"