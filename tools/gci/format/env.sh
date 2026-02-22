#!/bin/sh

set -eu

# Public environment variables for gci format command

# Export environment variables
export GCI_FORMAT_FLAGS="${GCI_FORMAT_FLAGS:--w --skip-generated -s standard -s default}"
export GCI_FORMAT_PREFIX="${GCI_FORMAT_PREFIX:-github.com/mecha-hq}"