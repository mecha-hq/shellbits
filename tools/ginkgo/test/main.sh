#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

echo "Running ginkgo tests..."
GOFLAGS="${GOLANG_GOFLAGS:--mod=mod}" ginkgo ${GINKGO_TEST_FLAGS} --timeout "${GINKGO_TEST_TIMEOUT}" -p "${GINKGO_TEST_PACKAGE}"