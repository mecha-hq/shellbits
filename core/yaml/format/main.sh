#!/bin/sh

set -eu

# Exec

find . \( -name '*.yaml' -o -name '*.yml' \) -type f -exec yq eval -P -I 2 -M -i {} \;
