#!/bin/sh

set -e
set -u

# Public environment variables for markdown lint command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export MARKDOWN_LINT_CONFIG_PATH="${MARKDOWN_LINT_CONFIG_PATH:-.rules/.markdownlint.yaml}"
export MARKDOWN_LINT_PATTERN="${MARKDOWN_LINT_PATTERN:-**/*.md}"
export MARKDOWN_LINT_IGNORE_PATTERNS="${MARKDOWN_LINT_IGNORE_PATTERNS:-#node_modules #.go}"
