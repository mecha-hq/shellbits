#!/bin/sh

set -e
set -u

# Public environment variables for tilt stop command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export TILT_STOP_PROJECT_NAME="${TILT_STOP_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename "$(pwd)")}}"
