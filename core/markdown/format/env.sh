#!/bin/sh

set -eu

# Public environment variables for markdown format command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export MARKDOWN_FORMAT_PATTERN="${MARKDOWN_FORMAT_PATTERN:-**/*.md}"
