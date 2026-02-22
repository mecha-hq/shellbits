#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec - use shfmt tool
${SHELLBITS_DIR}/tools/shfmt/format/main.sh .