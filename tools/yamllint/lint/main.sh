#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get YAML files
_yamlfiles=$(find . -name "*.yaml" -o -name "*.yml" | grep -v node_modules | grep -v \.git)

if [ -z "${_yamlfiles}" ]; then
    echo "No YAML files found to lint"
    exit 0
fi

echo "Linting YAML files..."
yamllint ${YAMLLINT_FLAGS} ${_yamlfiles}