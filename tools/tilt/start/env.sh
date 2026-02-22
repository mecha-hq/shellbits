#!/bin/sh

set -eu

# Public environment variables for tilt start command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export TILT_START_PROJECT_NAME="${TILT_START_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename "$(pwd)")}}"
