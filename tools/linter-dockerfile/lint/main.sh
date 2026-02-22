#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec - consolidated dockerfile linting
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
  "${DOCKERFILE_LINT_FIND_FLAGS}" \
  -exec hadolint ${DOCKERFILE_LINT_FLAGS} {} \;