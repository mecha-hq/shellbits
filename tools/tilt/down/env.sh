#!/bin/sh

set -eu

# Public environment variables for tilt down command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export TILT_DOWN_PROJECT_NAME="${TILT_DOWN_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename "$(pwd)")}}"
export TILT_DOWN_FORCE="${TILT_DOWN_FORCE:-${TILT_FORCE:-0}}"
