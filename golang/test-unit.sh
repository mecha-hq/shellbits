#!/bin/sh

set -e
set -o errexit -o nounset

go test -v -race -covermode=atomic -coverprofile=coveflare.out ./...
