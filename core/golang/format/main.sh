#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get Go files
_gofiles=$(find . -name "*.go" -type f -not -path '*/vendor/*' | sed 's/^\.\///g')

echo "formatting with gofmt.."
echo "${_gofiles}" | xargs -I {} sh -c 'gofmt -w -s {}'

echo "formatting with gofumpt.."
echo "${_gofiles}" | xargs -I {} sh -c 'gofumpt -w -extra {}'

echo "formatting with goimports.."
goimports -v -w -e -local "${GOLANG_FORMAT_PREFIX}" main.go
goimports -v -w -e -local "${GOLANG_FORMAT_PREFIX}" internal/

echo "formatting with gci.."
echo "${_gofiles}" | \
    xargs -I {} sh -c "gci write --skip-generated -s standard -s default -s \"Prefix(${GOLANG_FORMAT_PREFIX})\" {}"
