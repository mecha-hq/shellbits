#!/bin/sh

set -eu

export GO_VERSION="$(go version | cut -d ' ' -f 3)"

# Exec

goreleaser check
goreleaser release --debug --snapshot --clean

unset GO_VERSION
