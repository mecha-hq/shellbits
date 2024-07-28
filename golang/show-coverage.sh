#!/bin/sh

# shellcheck disable=SC2292

set -e
set -o errexit -o nounset

export _BIN_OPEN="open"
if [ "$(uname -s || true)" = "Linux" ]; then
    _BIN_OPEN="xdg-open"
fi

go tool cover -html=coveflare.out -o coveflare.html

go-cover-treemap -coverprofile coveflare.out > coveflare.svg && ${_BIN_OPEN} coveflare.svg

unset _BIN_OPEN
