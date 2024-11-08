#!/bin/sh

set -e
set -o errexit -o nounset

PREFIX=github.com/mecha-hq

GOFILES=$(find . -name "*.go" -type f -not -path '*/vendor/*' | sed 's/^\.\///g')

echo "formatting with gofmt.."
echo "${GOFILES}" | xargs -I {} sh -c 'gofmt -w -s {}'

echo "formatting with gofumpt.."
echo "${GOFILES}" | xargs -I {} sh -c 'gofumpt -w -extra {}'

echo "formatting with goimports.."
goimports -v -w -e -local "${PREFIX}" main.go
goimports -v -w -e -local "${PREFIX}" internal/

echo "formatting with gci.."
echo "${GOFILES}" | \
xargs -I {} sh -c "gci write --skip-generated -s standard -s default -s \"Prefix(${PREFIX})\" {}"
