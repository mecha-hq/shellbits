#!/bin/sh

# Public environment variables for tilt down command

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export TILT_DOWN_PROJECT_NAME="${TILT_DOWN_PROJECT_NAME:-${TILT_PROJECT_NAME}}"
export TILT_DOWN_FORCE="${TILT_DOWN_FORCE:-${TILT_FORCE:-0}}"
