#!/bin/sh

# Public environment variables for tilt start command

# Source common environment variables
. "${_script_dir}/../env.sh"

# TILT_START_PROJECT_NAME: Project name override for start command
TILT_START_PROJECT_NAME="${TILT_START_PROJECT_NAME:-${TILT_PROJECT_NAME}}"
