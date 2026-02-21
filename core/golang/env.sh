#!/bin/sh

set -e
set -u

# Common public environment variables for golang scripts

# Export environment variables
export GOLANG_GOFLAGS="${GOLANG_GOFLAGS:--mod=mod}"
export GO111MODULE="${GO111MODULE:-on}"
export GOPROXY="${GOPROXY:-https://proxy.golang.org,direct}"
