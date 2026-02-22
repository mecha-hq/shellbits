#!/bin/sh

set -eu

# JSON kit main script
# JSON operations using jsonlint and jq tools

JSON_KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Source environment variables
if [ -f "${JSON_KIT_DIR}/env.sh" ]; then
    . "${JSON_KIT_DIR}/env.sh"
fi

# Default action
ACTION="${1:-help}"

case "$ACTION" in
    format)
        shift
        "${JSON_KIT_DIR}/format/main.sh" "$@"
        ;;
    validate|lint)
        shift
        # Validate JSON files
        if [ $# -eq 0 ]; then
            set -- "."
        fi
        
        echo "Validating JSON files: $@"
        "${JSON_KIT_DIR}/lint/main.sh" "$@"
        ;;
    query)
        shift
        # Query JSON with jq
        if [ $# -lt 2 ]; then
            echo "Usage: $0 query <query> <file-pattern>"
            exit 1
        fi
        
        QUERY="$1"
        shift
        echo "Running jq query '$QUERY' on files: $@"
        # Use jq tool for querying
        find $@ -name "*.json" -type f -exec sh -c 'jq "$1" "$2"' _ "$QUERY" {} \;
        ;;
    pretty)
        shift
        # Pretty print JSON
        if [ $# -eq 0 ]; then
            set -- "."
        fi
        
        echo "Pretty printing JSON files: $@"
        find $@ -name "*.json" -type f -exec ${SHELLBITS_DIR}/tools/jq/format/main.sh {} \;
        ;;
    help|--help|-h)
        echo "JSON Kit - JSON operations using jsonlint and jq tools"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  format      - Format JSON files using jq"
        echo "  validate    - Validate JSON files using jsonlint"
        echo "  query       - Query JSON with jq"
        echo "  pretty      - Pretty print JSON using jq"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac