#!/bin/sh

set -eu

# Common public environment variables for docker scripts

# Export environment variables
export DOCKER_CONFIG="${DOCKER_CONFIG:-${HOME}/.docker}"
export DOCKER_HOST="${DOCKER_HOST:-}"
