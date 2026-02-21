#!/bin/sh

set -eu

# Shell kit main script
# Shell script operations using shellcheck and shfmt

SHELL_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${SHELL_KIT_DIR}/env.sh" ]; then
    . "${SHELL_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    format)
        shift
        "${SHELL_KIT_DIR}/format.sh" "$@"
        ;;
    lint)
        shift
        "${SHELL_KIT_DIR}/main.sh" "$@"
        ;;
    check)
        shift
        if [ $# -eq 0 ]; then
            set -- "**.sh"
        fi
        echo "Checking shell scripts: $@"
        "${SHELL_KIT_DIR}/main.sh" "$@"
        ;;
    all)
        shift
        if [ $# -eq 0 ]; then
            set -- "**.sh"
        fi
        echo "Processing shell scripts: $@"
        echo "Formatting..."
        "${SHELL_KIT_DIR}/format.sh" "$@"
        echo "Linting..."
        "${SHELL_KIT_DIR}/main.sh" "$@"
        ;;
    help|--help|-h)
        echo "Shell Kit - Shell script operations using shellcheck and shfmt"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  format      - Format shell scripts"
        echo "  lint        - Lint shell scripts"
        echo "  check       - Check shell script quality"
        echo "  all         - Run all shell script operations"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac