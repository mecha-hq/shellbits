#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# Source environment variables FIRST
. "${_script_dir}/env.sh"
# THEN set private variables using the now-loaded env vars
_project_name="${TILT_START_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Load utils

. "${_script_dir}/../utils.sh"

# Exec

start "${_project_name}"

echo "Done."
