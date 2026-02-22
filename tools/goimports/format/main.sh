#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get Go files
_gofiles=$(find . -name "*.go" -type f -not -path '*/vendor/*' | sed 's/^\.\/\/\/g')

if [ -z "${_gofiles}" ]; then
    echo "No Go files found to format with goimports"
    exit 0
fi

echo "Formatting Go imports with goimports..."
echo "${_gofiles}" | xargs -I {} sh -c "goimports ${GOIMPORTS_FORMAT_FLAGS} -local \"${GOIMPORTS_FORMAT_PREFIX}\" {}"

# Also format main.go and internal/ directories specifically
if [ -f "main.go" ]; then
    echo "Formatting main.go..."
    goimports ${GOIMPORTS_FORMAT_FLAGS} -local "${GOIMPORTS_FORMAT_PREFIX}" main.go
fi

if [ -d "internal/" ]; then
    echo "Formatting internal/ directory..."
    find internal/ -name "*.go" -type f | xargs -I {} sh -c "goimports ${GOIMPORTS_FORMAT_FLAGS} -local \"${GOIMPORTS_FORMAT_PREFIX}\" {}"
fi