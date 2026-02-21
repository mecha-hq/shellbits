#!/bin/sh

set -eu

# JSON kit main script
# JSON operations using jq and jsonlint

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
        "${JSON_KIT_DIR}/format.sh" "$@"
        ;;
    validate|lint)
        shift
        # Validate JSON files
        if [ $# -eq 0 ]; then
            echo "Usage: $0 validate <file-pattern>"
            exit 1
        fi
        
        echo "Validating JSON files: $@"
        # Add JSON validation logic here
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
        # Add jq query logic here
        ;;
    pretty)
        shift
        # Pretty print JSON
        if [ $# -eq 0 ]; then
            echo "Usage: $0 pretty <file-pattern>"
            exit 1
        fi
        
        echo "Pretty printing JSON files: $@"
        # Add pretty print logic here
        ;;
    help|--help|-h)
        echo "JSON Kit - JSON operations using jq and jsonlint"
        echo ""
        echo "Usage: $0 <command> [args...]"
        echo ""
        echo "Commands:"
        echo "  format      - Format JSON files"
        echo "  validate    - Validate JSON files"
        echo "  query       - Query JSON with jq"
        echo "  pretty      - Pretty print JSON"
        echo "  help        - Show this help"
        ;;
    *)
        echo "Error: Unknown command '$ACTION'" >&2
        echo "Run '$0 help' for usage" >&2
        exit 1
        ;;
esac