#!/bin/sh

# Public environment variables for tilt down command

# Source common environment variables
. "${_script_dir}/../env.sh"

# TILT_DOWN_PROJECT_NAME: Project name override for down command
TILT_DOWN_PROJECT_NAME="${TILT_DOWN_PROJECT_NAME:-${TILT_PROJECT_NAME}}"

# TILT_DOWN_FORCE: Force flag for down command (default: 0)
TILT_DOWN_FORCE="${TILT_DOWN_FORCE:-${TILT_FORCE:-0}}"
