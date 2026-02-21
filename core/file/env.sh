#!/bin/sh

set -eu

# Common public environment variables for file scripts

# Export environment variables
# No common environment variables needed for file scripts
export FILE_IGNORE_PATHS="${FILE_IGNORE_PATHS:-.git/,.github/,.vscode/,.idea/}"
