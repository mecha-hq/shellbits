#!/bin/sh

set -e
set -o errexit -o nounset

GOFLAGS=-mod=mod ginkgo run -vv --trace -covermode=count -coverprofile=coverage.out -timeout 300s -p test/e2e
