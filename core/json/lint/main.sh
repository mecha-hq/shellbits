#!/bin/sh

set -eu

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
