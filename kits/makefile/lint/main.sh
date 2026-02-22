#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get files to lint
_files="$@"

if [ -z "${_files}" ]; then
    _files="Makefile"
fi

echo "Linting Makefiles: ${_files}"
# Use the checkmake tool
${SHELLBITS_DIR}/tools/checkmake/lint/main.sh ${_files}