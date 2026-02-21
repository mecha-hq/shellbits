#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get Go version
_go_version=$(go version | cut -d ' ' -f 3)

export GO_VERSION="${_go_version}"

# Exec
goreleaser check
goreleaser release --debug --clean

unset GO_VERSION
