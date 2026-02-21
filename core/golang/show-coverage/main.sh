#!/bin/sh

# shellcheck disable=SC2292

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Determine the appropriate open command
_bin_open="${GOLANG_SHOW_COVERAGE_BIN_OPEN:-open}"
if [ "$(uname -s || true)" = "Linux" ]; then
    _bin_open="xdg-open"
fi

# Exec
go tool cover -html=coverage.out -o coverage.html

go-cover-treemap -coverprofile coverage.out > coverage.svg && ${_bin_open} coverage.svg

unset _bin_open
