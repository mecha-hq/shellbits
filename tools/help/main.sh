#!/bin/sh

set -eu

# Parse makefiles from arguments
_makefiles=$(printf "%s\n" "$@" | sed 's|//|/|g' | sort -u)

# Build targets list
_targets=""
for _makefile in ${_makefiles}; do
    if [ -f "${_makefile}" ]; then
        _targets="${_targets}$(grep -E '^[a-zA-Z0-9_%@/+=.-]+:' "${_makefile}" \
            | cut -d ':' -f 1 \
            | grep -vE '^\.(PHONY|SUFFIXES|DEFAULT|PRECIOUS|INTERMEDIATE|SECONDARY|SECONDEXPANSION|DELETE_ON_ERROR|IGNORE|LOW_RESOLUTION_TIME|SILENT|EXPORT_ALL_VARIABLES|NOTPARALLEL|ONESHELL|POSIX)$' \
            | sort -u \
            | sed 's/^/- /')
"
    fi
done

# Output results
printf "\nChoose a command run in %s:\n" "$(basename "$(pwd)")"
echo "${_targets}" | sort | uniq
echo
