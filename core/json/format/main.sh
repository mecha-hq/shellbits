#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
find . -name "*.json" -type f -exec sh -c 'jq -M . "$1" > "$1".tmp' \; -exec mv {}.tmp {} \;
