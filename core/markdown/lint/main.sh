#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
markdownlint-cli2-config "${MARKDOWN_LINT_CONFIG_PATH}" "${MARKDOWN_LINT_PATTERN}" "${MARKDOWN_LINT_IGNORE_PATTERNS}"
