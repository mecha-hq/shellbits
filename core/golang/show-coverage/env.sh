#!/bin/sh

set -e
set -u

# Public environment variables for golang show-coverage command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export GOLANG_SHOW_COVERAGE_BIN_OPEN="${GOLANG_SHOW_COVERAGE_BIN_OPEN:-open}"
