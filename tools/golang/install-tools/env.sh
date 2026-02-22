#!/bin/sh

set -eu

# Public environment variables for golang install-tools command

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source common environment variables
. "${_script_dir}/../env.sh"

# Export environment variables
export GOLANG_INSTALL_TOOLS="${GOLANG_INSTALL_TOOLS:-github.com/daixiang0/gci@latest github.com/davidrjenni/reftools/cmd/fillstruct@latest github.com/golangci/golangci-lint/cmd/golangci-lint@latest github.com/google/addlicense@latest github.com/nikolaydubina/go-cover-treemap@latest github.com/onsi/ginkgo/v2/ginkgo@latest go.uber.org/mock/mockgen@latest golang.org/x/tools/cmd/goimports@latest mvdan.cc/gofumpt@latest}"
