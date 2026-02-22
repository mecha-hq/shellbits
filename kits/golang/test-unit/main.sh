#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec - set package to test/unit and run ginkgo
GINKGO_TEST_PACKAGE="test/unit" ${SHELLBITS_DIR}/tools/ginkgo/test/main.sh