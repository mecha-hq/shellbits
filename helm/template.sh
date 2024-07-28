#!/bin/sh

set -e
set -o errexit -o nounset

CHART_NAME="${HELM_TEMPLATE_CHART_NAME:-$(basename $(pwd))}"
CHART_PATH="${HELM_TEMPLATE_CHART_PATH:-.}"
CHART_COLOR="${HELM_TEMPLATE_CHART_COLOR:-true}"

_HAS_NO_COLOR=false
_HAS_COLOR=false

while :; do
    case ${1:-} in
        -h|-\?|--help)            # Call a "show_help" function to display a synopsis, then exit.
            echo "Usage: $0 [--force] [--name=example] <project_name>"
            exit
            ;;
        --no-color)
            CHART_COLOR=false
            _HAS_NO_COLOR=true
            ;;
        --color)
            CHART_COLOR=true
            _HAS_COLOR=true
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

if [[ ${_HAS_NO_COLOR} == true && ${_HAS_COLOR} == true ]]; then
    echo "Error: You can't use --no-color and --color flags at the same time."
    exit 1
fi

helm template "${CHART_NAME}" "${CHART_PATH}" --atomic --create-namespace --dry-run --debug | \
    yq \
        $( [[ "$(CHART_COLOR)" == false ]] && echo --no-colors ) \
        $( [[ "$(CHART_COLOR)" == true ]] && echo --colors )
