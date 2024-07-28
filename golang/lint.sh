#!/bin/sh

set -e
set -o errexit -o nounset

golangci-lint -v run --color=always --config=.rules/.golangci.yml ./...
