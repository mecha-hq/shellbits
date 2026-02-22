#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get Go files
_gofiles=$(find . -name "*.go" -type f -not -path '*/vendor/*' | sed 's/^\.\/\/\/g')

echo "formatting with go fmt.."
if [ -n "${_gofiles}" ]; then
    echo "${_gofiles}" | xargs -I {} sh -c "${SHELLBITS_DIR}/tools/go/fmt/main.sh"
fi

echo "formatting with gofumpt.."
if [ -n "${_gofiles}" ]; then
    echo "${_gofiles}" | xargs -I {} sh -c "${SHELLBITS_DIR}/tools/gofumpt/format/main.sh"
fi

echo "formatting with goimports.."
if [ -f "main.go" ]; then
    ${SHELLBITS_DIR}/tools/goimports/format/main.sh
fi

if [ -d "internal/" ]; then
    (cd internal/ && ${SHELLBITS_DIR}/tools/goimports/format/main.sh)
fi

echo "formatting with gci.."
if [ -n "${_gofiles}" ]; then
    echo "${_gofiles}" | xargs -I {} sh -c "${SHELLBITS_DIR}/tools/gci/format/main.sh"
fi