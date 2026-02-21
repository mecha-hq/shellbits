#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Cleanup function to unset all environment variables
cleanup_env() {
    # Common variables
    unset TILT_PROJECT_NAME
    unset TILT_FORCE
    # Start-specific variables
    unset TILT_START_PROJECT_NAME
}

# Set trap to cleanup on script exit
trap cleanup_env EXIT

# Source environment variables
. "${_script_dir}/env.sh"

# Set private variables using the now-loaded env vars
_project_name="${TILT_START_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Load utils

. "${_script_dir}/../utils.sh"

# Exec

start "${_project_name}"

echo "Done."
