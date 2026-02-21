#!/bin/sh

set -e
set -u

# Public environment variables for brew install-tools command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export BREW_INSTALL_TOOLS="${BREW_INSTALL_TOOLS:-checkmake markdownlint-cli2 jsonlint}"
