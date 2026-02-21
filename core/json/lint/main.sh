#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
find . \
  -type f \
  -not -path "*/.git" \
  -not -path "*/.github" \
  -not -path "*/.go/*" \
  -not -path "*/.vscode" \
  -not -path "*/.idea" \
  -name "*.json" \
  -exec jsonlint -c -q -t '  ' {} \;
