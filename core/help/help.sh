#!/bin/sh

set -e
set -o errexit -o nounset

printf "\nChoose a command run in $(basename $(pwd)):\n"

MAKEFILES=$(printf "%s\n" "$@" | sed 's|//|/|g' | sort -u)

TARGETS=""
for MAKEFILE in ${MAKEFILES}; do
    if [ -f "$MAKEFILE" ]; then
        TARGETS="${TARGETS}$(grep -E '^[a-zA-Z0-9_%@/+=.-]+:' "$MAKEFILE" \
            | cut -d ':' -f 1 \
            | grep -vE '^\.(PHONY|SUFFIXES|DEFAULT|PRECIOUS|INTERMEDIATE|SECONDARY|SECONDEXPANSION|DELETE_ON_ERROR|IGNORE|LOW_RESOLUTION_TIME|SILENT|EXPORT_ALL_VARIABLES|NOTPARALLEL|ONESHELL|POSIX)$' \
            | sort -u \
            | sed 's/^/- /')
"
    fi
done

echo "${TARGETS}" | sort | uniq
echo
