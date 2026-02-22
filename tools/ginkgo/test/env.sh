#!/bin/sh

set -eu

# Public environment variables for ginkgo test command

# Export environment variables
export GINKGO_TEST_FLAGS="${GINKGO_TEST_FLAGS:--vv --trace -covermode=count -coverprofile=coverage.out}"
export GINKGO_TEST_TIMEOUT="${GINKGO_TEST_TIMEOUT:-300s}"
export GINKGO_TEST_PACKAGE="${GINKGO_TEST_PACKAGE:-.}"