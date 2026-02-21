#!/bin/sh

set -eu

# Common public environment variables for goreleaser scripts

# Export environment variables
export GORELEASER_CURRENT_TAG="${GORELEASER_CURRENT_TAG:-}"
export GORELEASER_PREVIOUS_TAG="${GORELEASER_PREVIOUS_TAG:-}"
export GORELEASER_SKIP_PUBLISH="${GORELEASER_SKIP_PUBLISH:-false}"
