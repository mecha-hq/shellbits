#!/bin/sh

set -eu

# Public environment variables for markdown lint command

# Export environment variables
export MARKDOWN_LINT_CONFIG_PATH="${MARKDOWN_LINT_CONFIG_PATH:-.rules/.markdownlint.yaml}"
export MARKDOWN_LINT_PATTERN="${MARKDOWN_LINT_PATTERN:-**/*.md}"
export MARKDOWN_LINT_IGNORE_PATTERNS="${MARKDOWN_LINT_IGNORE_PATTERNS:-#node_modules #.go}"
