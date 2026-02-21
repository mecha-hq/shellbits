#!/bin/sh

# Public environment variables for tilt stop command

# Source common environment variables
. "${_script_dir}/../env.sh"

# TILT_STOP_PROJECT_NAME: Project name override for stop command
TILT_STOP_PROJECT_NAME="${TILT_STOP_PROJECT_NAME:-${TILT_PROJECT_NAME}}"
