#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
file-cr --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
file-crlf --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
file-nullbyte --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
file-trailing-newline --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
file-trailing-single-newline --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
file-trailing-space --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
file-utf8 --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
file-utf8-bom --text --ignore "${FILE_FORMAT_IGNORE_PATHS}" --fix --path .
