#!/bin/sh

set -e
set -o errexit -o nounset

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Parse arguments
while :; do
    case ${1:-} in
        -h|-\?|--help)            # Call a "show_help" function to display a synopsis, then exit.
            echo "Usage: $0 [--force] [--name=example] <project_name>"
            exit
            ;;
        --no-color)
            HELM_TEMPLATE_CHART_COLOR=false
            _has_no_color=true
            ;;
        --color)
            HELM_TEMPLATE_CHART_COLOR=true
            _has_color=true
            ;;
        --)                       # End of all options.
            shift
            break
            ;;
        *)                        # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

if [ ${_has_no_color:-false} = true ] && [ ${_has_color:-false} = true ]; then
    echo "Error: You can't use --no-color and --color flags at the same time." >&2
    exit 1
fi

# Exec
helm template "${HELM_TEMPLATE_CHART_NAME}" "${HELM_TEMPLATE_CHART_PATH}" --atomic --create-namespace --dry-run --debug | \
    yq \
        $( [ "${HELM_TEMPLATE_CHART_COLOR}" = false ] && echo --no-colors ) \
        $( [ "${HELM_TEMPLATE_CHART_COLOR}" = true ] && echo --colors )
