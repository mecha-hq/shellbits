#!/bin/sh

# shellcheck disable=SC2016

set -e
set -o errexit -o nounset

mise install && \
yq -M '.tools | keys | .[]' .mise.toml -oy | \
xargs -I {} -n 1 sh -c 'echo {} = \"$(mise latest {} 2>/dev/null)\"' > .mise.tools.toml && \
sed -i.bak '/\[tools\]/,/^$/{
/\[tools\]/!{
/^$/!d
}
}' .mise.toml && \
sed -i '' '/\[tools\]/r .mise.tools.toml' .mise.toml && \
rm .mise.tools.toml .mise.toml.bak
