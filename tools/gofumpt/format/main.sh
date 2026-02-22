#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get Go files
_gofiles=$(find . -name "*.go" -type f -not -path '*/vendor/*' | sed 's/^\.\/\/\/g')

if [ -z "${_gofiles}" ]; then
    echo "No Go files found to format with gofumpt"
    exit 0
fi

echo "Formatting Go files with gofumpt..."
echo "${_gofiles}" | xargs -I {} sh -c 'gofumpt ${GOFUMPT_FORMAT_FLAGS} {}'