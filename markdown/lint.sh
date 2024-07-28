#!/bin/sh

set -e
set -o errexit -o nounset

markdownlint-cli2-config ".rules/.markdownlint.yaml" "**/*.md" "#node_modules" "#.go"
