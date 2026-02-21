#!/bin/sh

set -e
set -u

# Common public environment variables for cosign scripts

# Export environment variables
export COSIGN_EXPERIMENTAL="${COSIGN_EXPERIMENTAL:-0}"
export COSIGN_REPOSITORY="${COSIGN_REPOSITORY:-}"
