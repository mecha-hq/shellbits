#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get shell files
_shellfiles=$(find . -name "*.sh" | grep -v node_modules | grep -v \.git)

if [ -z "${_shellfiles}" ]; then
    echo "No shell files found to lint"
    exit 0
fi

echo "Linting shell files with shellcheck..."
shellcheck ${SHELLCHECK_FLAGS} ${_shellfiles}