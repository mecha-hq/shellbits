#!/bin/sh

find ./core/tilt -name *.sh -type f | \
    xargs -I{} shellcheck -a -o all -s sh --source-path=SCRIPTDIR -x -- {}
