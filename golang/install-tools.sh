#!/bin/sh

set -e
set -o errexit -o nounset

go install github.com/daixiang0/gci@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/google/addlicense@latest
go install github.com/nikolaydubina/go-cover-treemap@latest
go install github.com/onsi/ginkgo/v2/ginkgo@latest
go install go.uber.org/mock/mockgen@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest
