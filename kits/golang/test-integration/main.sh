#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Exec - set package to test/integration and run ginkgo
GINKGO_TEST_PACKAGE="test/integration" ${SHELLBITS_DIR}/tools/ginkgo/test/main.sh