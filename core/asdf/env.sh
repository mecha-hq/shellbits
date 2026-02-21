#!/bin/sh

set -e
set -u

# Common public environment variables for asdf scripts

# Export environment variables
export ASDF_CONFIG_FILE="${ASDF_CONFIG_FILE:-${HOME}/.asdfrc}"
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-${HOME}/.asdf}"
export ASDF_DEFAULT_TOOL_VERSION_FILENAME=".tool-versions"
