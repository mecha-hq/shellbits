#!/bin/sh

set -eu

# Container kit main script
# Combines docker, hadolint, and cosign functionality

CONTAINER_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${CONTAINER_KIT_DIR}/env.sh" ]; then
    . "${CONTAINER_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    docker)
        shift
        "${CONTAINER_KIT_DIR}/docker/main.sh" "$@"
        ;;
    hadolint)
        shift
        "${CONTAINER_KIT_DIR}/hadolint/main.sh" "$@"
        ;;
    cosign)
        shift
        "${CONTAINER_KIT_DIR}/cosign/main.sh" "$@"
        ;;
    lint)
        # Run hadolint on Dockerfiles
        shift
        "${CONTAINER_KIT_DIR}/hadolint/main.sh" "$@"
        ;;
    build)
        # Build container with optional signing
        shift
        "${CONTAINER_KIT_DIR}/docker/main.sh" "$@"
        if [ "${CONTAINER_SIGN:-false}" = "true" ]; then
            echo "Signing container image..."
            "${CONTAINER_KIT_DIR}/cosign/main.sh" "$@"
        fi
        ;;
    help|--help|-h)
        echo "Container Kit - Docker, Hadolint, and Cosign integration"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  docker       - Docker operations"
        echo "  hadolint     - Hadolint operations"
        echo "  cosign       - Cosign operations"
        echo "  lint         - Lint Dockerfiles (alias for hadolint)"
        echo "  build        - Build container (with optional signing)"
        echo "  help         - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac