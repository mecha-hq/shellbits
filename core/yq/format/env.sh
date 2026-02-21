#!/bin/sh

set -eu

# Public environment variables for yq format command

# Export environment variables
export YQ_FORMAT_FLAGS="${YQ_FORMAT_FLAGS:=-P -I 2 -M}"
