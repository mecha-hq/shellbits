#!/bin/sh

set -e
set -o errexit -o nounset

printf "\nChoose a command run in $(basename $(pwd)):\n"

TARGETS=""
for MAKEFILE in "${@}"; do
    TARGETS+=$(cat "${MAKEFILE}" | grep -E '^[a-z0-9_-]+\:' | cut -d ':' -f 1 | sort | uniq | sed 's/^/- /')
    TARGETS+="\n"
done

printf "${TARGETS}" | sort | uniq
echo
