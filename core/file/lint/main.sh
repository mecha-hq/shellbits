#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
file-cr --text --ignore "${FILE_LINT_IGNORE_PATHS}" --path .
file-crlf --text --ignore "${FILE_LINT_IGNORE_PATHS}" --path .
file-trailing-single-newline --text --ignore "${FILE_LINT_IGNORE_PATHS}" --path .
file-trailing-space --text --ignore "${FILE_LINT_IGNORE_PATHS}" --path .
file-utf8 --text --ignore "${FILE_LINT_IGNORE_PATHS}" --path .
file-utf8-bom --text --ignore "${FILE_LINT_IGNORE_PATHS}" --path .
