#!/bin/sh

set -e
set -u

# Public environment variables for file lint command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export FILE_LINT_IGNORE_PATHS="${FILE_LINT_IGNORE_PATHS:-.git/,.go/,.github/,.vscode/,.idea/}"
