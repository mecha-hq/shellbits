#!/bin/sh

set -eu

# Container kit main script
# Container operations using dockerfile linting and cosign

CONTAINER_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${CONTAINER_KIT_DIR}/env.sh" ]; then
    . "${CONTAINER_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    test-signature)
        shift
        "${CONTAINER_KIT_DIR}/test-signature/main.sh" "$@"
        ;;
    lint-dockerfile)
        shift
        "${CONTAINER_KIT_DIR}/lint-dockerfile/main.sh" "$@"
        ;;
    lint)
        # Alias for lint-dockerfile
        shift
        "${CONTAINER_KIT_DIR}/lint-dockerfile/main.sh" "$@"
        ;;
    build)
        # Build container with optional signing
        shift
        # Add build logic here
        if [ "${CONTAINER_SIGN:-false}" = "true" ]; then
            echo "Signing container image..."
            "${CONTAINER_KIT_DIR}/test-signature/main.sh" "$@"
        fi
        ;;
    help|--help|-h)
        echo "Container Kit - Container operations using dockerfile linting and cosign"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  test-signature   - Test and sign container images"
        echo "  lint-dockerfile  - Lint Dockerfiles"
        echo "  lint              - Alias for lint-dockerfile"
        echo "  build             - Build container (with optional signing)"
        echo "  help              - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac