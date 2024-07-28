#!/bin/sh

# shellcheck disable=SC1091,SC2292

set -o errexit
set -o nounset

SETTINGS="${1:settings}"

# see settings.dist for an example
. "${SETTINGS:}"

if [ -z "${GEN_ROOT:-}" ]; then
    : "${GEN_COMMIT?Need to set GEN_COMMIT to kubernetes-client/gen commit}"
    TEMP_FOLDER=$(mktemp -d)
    trap "rm -rf \"${TEMP_FOLDER}\"" EXIT INT

    GEN_ROOT="${TEMP_FOLDER}/gen"
    echo ">>> Cloning gen repo"
    git clone --recursive https://github.com/kubernetes-client/gen.git "${GEN_ROOT}"
    (cd "${GEN_ROOT}" && git checkout "${GEN_COMMIT}")
else
    echo ">>> Reusing gen repo at ${GEN_ROOT}"
fi

TYPESCRIPT_SH="${GEN_ROOT}/openapi/typescript.sh"
echo ">>> Running ${TYPESCRIPT_SH}"
${TYPESCRIPT_SH} "${SETTINGS}/gen" "${SETTINGS:-settings}"
echo ">>> Done."
