#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get shell files
_shellfiles=$(find . -name "*.sh" | grep -v node_modules | grep -v \.git)

if [ -z "${_shellfiles}" ]; then
    echo "No shell files found to format"
    exit 0
fi

echo "Formatting shell files with shfmt..."
shfmt ${SHFMT_FORMAT_FLAGS} ${_shellfiles}