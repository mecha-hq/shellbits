#!/bin/sh

set -eu

# Markdown kit main script
# Markdown operations using markdownlint-cli2

MARKDOWN_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${MARKDOWN_KIT_DIR}/env.sh" ]; then
    . "${MARKDOWN_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    format)
        shift
        "${MARKDOWN_KIT_DIR}/format.sh" "$@"
        ;;
    lint)
        shift
        "${MARKDOWN_KIT_DIR}/main.sh" "$@"
        ;;
    check)
        shift
        if [ $# -eq 0 ]; then
            set -- "**.md"
        fi
        echo "Checking markdown files: $@"
        "${MARKDOWN_KIT_DIR}/main.sh" "$@"
        ;;
    all)
        shift
        if [ $# -eq 0 ]; then
            set -- "**.md"
        fi
        echo "Processing markdown files: $@"
        echo "Formatting..."
        "${MARKDOWN_KIT_DIR}/format.sh" "$@"
        echo "Linting..."
        "${MARKDOWN_KIT_DIR}/main.sh" "$@"
        ;;
    help|--help|-h)
        echo "Markdown Kit - Markdown operations using markdownlint-cli2"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  format      - Format markdown files"
        echo "  lint        - Lint markdown files"
        echo "  check       - Check markdown quality"
        echo "  all         - Run all markdown operations"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac