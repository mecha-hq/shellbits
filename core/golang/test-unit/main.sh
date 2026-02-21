#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
GOFLAGS="${GOLANG_GOFLAGS:--mod=mod}" ginkgo run -vv --trace -covermode=count -coverprofile=coverage.out -timeout 300s -p test/unit
