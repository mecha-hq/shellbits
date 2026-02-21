#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec
find . \( -name '*.yaml' -o -name '*.yml' \) -type f -exec yq eval -P -I 2 -M -i {} \;
