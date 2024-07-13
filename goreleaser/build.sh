#!/bin/sh

set -e
set -o errexit -o nounset

# Remove non-semver, helm-chart tags
# git tag -l | grep helm-chart-v | xargs git tag -d

GO_VERSION=$(go version | cut -d ' ' -f 3)

export GO_VERSION

goreleaser check
goreleaser release --debug --snapshot --clean

unset GO_VERSION
