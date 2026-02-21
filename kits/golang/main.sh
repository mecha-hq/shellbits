#!/bin/sh

set -eu

# Golang kit main script
# Combines Go, Goreleaser, and formatting functionality

GOLANG_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${GOLANG_KIT_DIR}/env.sh" ]; then
    . "${GOLANG_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    go)
        shift
        # Basic go commands
        if [ $# -eq 0 ]; then
            echo "Usage: $0 go <go-command> [args...]"
            echo "Example: $0 go build ./..."
            exit 1
        fi
        go "$@"
        ;;
    format)
        shift
        "${GOLANG_KIT_DIR}/format/main.sh" "$@"
        ;;
    build)
        shift
        "${GOLANG_KIT_DIR}/goreleaser/main.sh" "$@"
        ;;
    release)
        shift
        # Build and release
        "${GOLANG_KIT_DIR}/goreleaser/main.sh" "$@"
        ;;
    lint)
        shift
        # Run go vet and other linters
        go vet ./... "$@"
        ;;
    test)
        shift
        # Run tests with race detector
        go test -race ./... "$@"
        ;;
    all)
        # Run format, lint, and tests
        echo "Formatting code..."
        "${GOLANG_KIT_DIR}/format/main.sh" "$@"
        
        echo "Running linters..."
        go vet ./... "$@"
        
        echo "Running tests..."
        go test -race ./... "$@"
        ;;
    help|--help|-h)
        echo "Golang Kit - Go, Goreleaser, and formatting integration"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  go          - Run go commands directly"
        echo "  format      - Format Go code"
        echo "  build       - Build Go project"
        echo "  release     - Create release with goreleaser"
        echo "  lint        - Run linters (go vet)"
        echo "  test        - Run tests with race detector"
        echo "  all         - Run format, lint, and tests"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac