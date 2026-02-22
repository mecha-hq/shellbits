#!/bin/sh

set -eu

# Public environment variables for file format command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export FILE_FORMAT_IGNORE_PATHS="${FILE_FORMAT_IGNORE_PATHS:-${FILE_IGNORE_PATHS:-}}"
