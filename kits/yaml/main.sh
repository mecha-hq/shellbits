#!/bin/sh

set -eu

# YAML kit main script
# YAML operations using yamllint and yq

YAML_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${YAML_KIT_DIR}/env.sh" ]; then
    . "${YAML_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    format)
        shift
        "${YAML_KIT_DIR}/format.sh" "$@"
        ;;
    lint)
        shift
        "${YAML_KIT_DIR}/main.sh" "$@"
        ;;
    validate)
        shift
        if [ $# -eq 0 ]; then
            set -- "**.yaml" "**.yml"
        fi
        echo "Validating YAML files: $@"
        "${YAML_KIT_DIR}/main.sh" "$@"
        ;;
    query)
        shift
        # Query YAML with yq
        if [ $# -lt 2 ]; then
            echo "Usage: $0 query <query> <file-pattern>"
            exit 1
        fi
        
        QUERY="$1"
        shift
        echo "Running yq query '$QUERY' on files: $@"
        # Add yq query logic here
        ;;
    all)
        shift
        if [ $# -eq 0 ]; then
            set -- "**.yaml" "**.yml"
        fi
        echo "Processing YAML files: $@"
        echo "Formatting..."
        "${YAML_KIT_DIR}/format.sh" "$@"
        echo "Linting..."
        "${YAML_KIT_DIR}/main.sh" "$@"
        ;;
    help|--help|-h)
        echo "YAML Kit - YAML operations using yamllint and yq"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  format      - Format YAML files"
        echo "  lint        - Lint YAML files"
        echo "  validate    - Validate YAML files"
        echo "  query       - Query YAML with yq"
        echo "  all         - Run all YAML operations"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac