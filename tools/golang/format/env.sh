#!/bin/sh

set -eu

# Public environment variables for golang format command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export GOLANG_FORMAT_PREFIX="${GOLANG_FORMAT_PREFIX:-github.com/mecha-hq}"
