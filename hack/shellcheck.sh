#!/bin/sh

set -e
set -u

_tool=${1:-}

if [ -z "${_tool}" ]; then
    echo "tool must be specified as first argument"
    exit 1
fi

find "./core/${_tool}" -name *.sh -type f | \
    xargs -I{} shellcheck -a -o all -s sh --source-path=SCRIPTDIR -x -- {}
