#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

export GO_VERSION="$(go version | cut -d ' ' -f 3)"

echo "Running goreleaser release..."
goreleaser check
goreleaser release ${GORELEASER_RELEASE_FLAGS}

unset GO_VERSION