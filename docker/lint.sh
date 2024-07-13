#!/bin/sh

set -e
set -o errexit -o nounset

set -- \
  -not -path './.git/*' \
  -not -path './.github/*' \
  -not -path './.vscode/*' \
  -not -path './.idea/*' \
  "$@"

find . \
  -type f \
  -name '*Dockerfile*' \
  "$@" \
  -exec hadolint {} \;
