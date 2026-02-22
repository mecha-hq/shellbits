#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec - use yq tool
find . \( -name '*.yaml' -o -name '*.yml' \) -type f -exec ${SHELLBITS_DIR}/tools/yq/format/main.sh {} \;