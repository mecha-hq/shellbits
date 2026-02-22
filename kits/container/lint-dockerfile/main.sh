#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec - use consolidated dockerfile linter tool
# For now, use hadolint directly until we create the consolidated tool
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
  "${DOCKER_LINT_DOCKERFILE_FIND_FLAGS:-}" \
  -exec hadolint ${HADOLINT_LINT_FLAGS:-} {} \;