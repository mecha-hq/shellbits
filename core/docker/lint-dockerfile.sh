#!/bin/sh

set -e
set -o errexit -o nounset

find . \
  -type f \
  -name '*Dockerfile*' \
  -not -path './.git/*' \
  -not -path './.github/*' \
  -not -path './.idea/*' \
  -not -path './.vscode/*' \
  -not -name '._*' \
  -not -name '.DS_Store' \
  -not -name '.gitkeep' \
  "$@" \
  -exec hadolint {} \;
