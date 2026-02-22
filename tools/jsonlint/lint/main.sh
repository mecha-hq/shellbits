#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get JSON files
_jsonfiles=$(find . -name "*.json" | grep -v node_modules | grep -v \.git)

if [ -z "${_jsonfiles}" ]; then
    echo "No JSON files found to lint"
    exit 0
fi

echo "Linting JSON files..."
# Use jq for JSON validation as a fallback if jsonlint is not available
if command -v jsonlint >/dev/null 2>&1; then
    jsonlint ${JSONLINT_FLAGS} ${_jsonfiles}
else
    echo "jsonlint not found, using jq for validation..."
    for file in ${_jsonfiles}; do
        if ! jq empty "${file}" >/dev/null 2>&1; then
            echo "Invalid JSON in ${file}"
            exit 1
        fi
    done
    echo "All JSON files are valid"
fi