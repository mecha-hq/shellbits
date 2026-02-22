#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/../env.sh"

# Exec - use jq tool for formatting
find . -name "*.json" -type f -exec ${SHELLBITS_DIR}/tools/jq/format/main.sh {} \;