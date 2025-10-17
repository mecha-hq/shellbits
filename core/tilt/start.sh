#!/bin/sh

set -e
set -o errexit -o nounset

# Variables

SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
PROJECT_NAME="${TILT_START_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"

# Load utils

. "${SCRIPT_DIR}/utils.sh"

# Exec

start "${PROJECT_NAME}"

echo "Done."
