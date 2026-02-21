#!/bin/sh

set -eu

# Public environment variables for markdown format command

# Export environment variables
export MARKDOWN_FORMAT_PATTERN="${MARKDOWN_FORMAT_PATTERN:-**/*.md}"
