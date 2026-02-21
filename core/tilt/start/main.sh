#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Load utils

. "${_script_dir}/../utils.sh"

# Source environment variables

. "${_script_dir}/env.sh"

# Exec

start "${TILT_START_PROJECT_NAME}"

echo "Done."
