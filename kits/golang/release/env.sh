#!/bin/sh

set -eu

# Public environment variables for goreleaser release command

# Export environment variables
export GORELEASER_RELEASE_FLAGS="${GORELEASER_RELEASE_FLAGS:---clean}"