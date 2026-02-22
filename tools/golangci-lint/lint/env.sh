#!/bin/sh

set -eu

# Public environment variables for golangci-lint command

# Export environment variables
export GOLANGCI_LINT_FLAGS="${GOLANGCI_LINT_FLAGS:--v run --color=always}"
export GOLANGCI_LINT_CONFIG="${GOLANGCI_LINT_CONFIG:-.rules/.golangci.yml}"