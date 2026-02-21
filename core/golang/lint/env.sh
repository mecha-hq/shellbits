#!/bin/sh

set -e
set -u

# Public environment variables for golang lint command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
# No specific environment variables needed for this command
