#!/bin/sh

set -eu

# Exec
find . -name "*.json" -type f -exec sh -c 'jq -M . "$1" > "$1".tmp' \; -exec mv {}.tmp {} \;
