#!/bin/sh

set -eu

# Public environment variables for shellcheck command

# Export environment variables
export SHELLCHECK_FLAGS="${SHELLCHECK_FLAGS:--a -o all -s sh --source-path=SCRIPTDIR}"