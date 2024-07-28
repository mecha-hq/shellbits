#!/bin/sh

set -e
set -o errexit -o nounset

go test -tags=integration -v -race -covermode=atomic -coverprofile=coveflare.out ./...
