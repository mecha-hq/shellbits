#!/bin/sh

set -e
set -o errexit -o nounset

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
_project_name="${TILT_START_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Load utils

. "${_script_dir}/utils.sh"

# Exec

start "${_project_name}"

echo "Done."
