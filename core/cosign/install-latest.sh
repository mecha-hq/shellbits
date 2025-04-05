#!/bin/sh -x

set -e
set -o errexit -o nounset

UNAME_OS="$(uname -s)"
UNAME_ARCH="$(uname -m)"

case "${UNAME_OS}" in
    Linux*)     OSNAME=linux;;
    Darwin*)    OSNAME=darwin;;
    MINGW*)     OSNAME=windows;;
    *)          echo "UNSUPPORTED OS: ${UNAME_OS}"; exit 1;;
esac

ARCH=amd64
if [ "${UNAME_ARCH}" = "aarch64" ] || [ "${UNAME_ARCH}" = "arm64" ]; then
  ARCH=arm64
fi

if [ -f /usr/bin/cosign ]; then
  mv /usr/bin/cosign /usr/bin/cosign.bak
fi

curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-${OSNAME}-${ARCH}"
mv "cosign-${OSNAME}-${ARCH}" /tmp/cosign
chmod +x /tmp/cosign

mv /tmp/cosign /usr/bin/cosign
