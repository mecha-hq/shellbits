#!/bin/sh

set -eu

# Makefile kit main script
# Makefile operations using checkmake

MAKEFILE_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${MAKEFILE_KIT_DIR}/env.sh" ]; then
    . "${MAKEFILE_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    lint)
        shift
        # Lint Makefiles - primary action
        if [ $# -eq 0 ]; then
            set -- "Makefile"
        fi
        
        "${MAKEFILE_KIT_DIR}/lint/main.sh" "$@"
        ;;
    check)
        shift
        # Check Makefile quality
        if [ $# -eq 0 ]; then
            set -- "Makefile"
        fi
        
        echo "Checking Makefile quality: $@"
        "${MAKEFILE_KIT_DIR}/lint/main.sh" "$@"
        ;;
    validate)
        shift
        # Validate Makefile syntax
        if [ $# -eq 0 ]; then
            set -- "Makefile"
        fi
        
        echo "Validating Makefile syntax: $@"
        # Add validation logic here
        ;;
    all)
        shift
        # Run all makefile operations
        if [ $# -eq 0 ]; then
            set -- "Makefile"
        fi
        
        echo "Processing Makefile: $@"
        echo "Linting..."
        "${MAKEFILE_KIT_DIR}/lint/main.sh" "$@"
        echo "Validating..."
        # Add validation logic here
        ;;
    help|--help|-h)
        echo "Makefile Kit - Makefile operations using checkmake"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  lint        - Lint Makefiles (primary action)"
        echo "  check       - Check Makefile quality"
        echo "  validate    - Validate Makefile syntax"
        echo "  all         - Run all makefile operations"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac