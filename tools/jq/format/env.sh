#!/bin/sh

set -eu

# Public environment variables for jq format command

# Export environment variables
export JQ_FORMAT_FLAGS="${JQ_FORMAT_FLAGS:---indent 2 --monochrome-output --sort-keys}"
