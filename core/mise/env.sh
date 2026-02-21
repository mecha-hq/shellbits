#!/bin/sh

set -e
set -u

# Common public environment variables for mise scripts

# Export environment variables
export MISE_RAW="${MISE_RAW:-0}"
export MISE_YES="${MISE_YES:-0}"
export MISE_QUIET="${MISE_QUIET:-0}"
