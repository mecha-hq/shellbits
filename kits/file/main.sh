#!/bin/sh

set -eu

# File kit main script
# File operations and management

FILE_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${FILE_KIT_DIR}/env.sh" ]; then
    . "${FILE_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    lint)
        shift
        # Lint files - primary action
        if [ $# -eq 0 ]; then
            echo "Usage: $0 lint <file-pattern>"
            exit 1
        fi
        
        "${FILE_KIT_DIR}/lint/main.sh" "$@"
        ;;
    format)
        shift
        # Format files
        if [ $# -eq 0 ]; then
            echo "Usage: $0 format <file-pattern>"
            exit 1
        fi
        
        echo "Formatting files: $@"
        # Add file formatting logic here
        ;;
    check)
        shift
        # Check file quality
        if [ $# -eq 0 ]; then
            echo "Usage: $0 check <file-pattern>"
            exit 1
        fi
        
        echo "Checking files: $@"
        # Add file checking logic here
        ;;
    all)
        shift
        # Run all file operations
        if [ $# -eq 0 ]; then
            echo "Usage: $0 all <file-pattern>"
            exit 1
        fi
        
        echo "Processing files: $@"
        echo "Linting..."
        "${FILE_KIT_DIR}/lint/main.sh" "$@"
        echo "Formatting..."
        # Add formatting logic
        echo "Checking..."
        # Add checking logic
        ;;
    help|--help|-h)
        echo "File Kit - File operations and management"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  lint        - Lint files (primary action)"
        echo "  format      - Format files"
        echo "  check       - Check file quality"
        echo "  all         - Run all file operations"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac