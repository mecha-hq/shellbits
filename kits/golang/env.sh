# Golang kit environment variables
# This file contains configuration for the golang kit

# Go configuration
GOLANG_GO_VERSION="1.21"
GOLANG_GOPROXY="https://proxy.golang.org,direct"
GOLANG_GOPRIVATE=""
GOLANG_GOSUMDB="sum.golang.org"

# Formatting configuration
GOLANG_FORMAT_TOOLS="gofmt,goimports,gofumpt"
GOLANG_FORMAT_WRITE="false"

# Goreleaser configuration
GOLANG_GORELEASER_CONFIG=".goreleaser.yml"
GOLANG_GORELEASER_SNAPSHOT="false"
GOLANG_GORELEASER_CLEAN="false"

# Testing configuration
GOLANG_TEST_COVERAGE="false"
GOLANG_TEST_VERBOSE="false"
GOLANG_TEST_TIMEOUT="10m"

# Export all variables
for var in $(compgen -v | grep "^GOLANG_"); do
    export "$var"
done