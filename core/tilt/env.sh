#!/bin/sh

# Common public environment variables for tilt scripts

# TILT_PROJECT_NAME: The name of the project (default: basename of current directory)
# This is used across all tilt commands
TILT_PROJECT_NAME="${TILT_PROJECT_NAME:-}"

# TILT_FORCE: Global force flag (default: 0)
# Used by up and down commands
TILT_FORCE="${TILT_FORCE:-0}"
