#!/bin/sh

set -e
set -u

# Common public environment variables for tilt scripts

# Export environment variables
export TILT_PROJECT_NAME="${TILT_PROJECT_NAME:-}"
export TILT_FORCE="${TILT_FORCE:-0}"
