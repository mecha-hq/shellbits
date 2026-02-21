#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Get system information
_uname_os=$(uname -s)
_uname_arch=$(uname -m)

# Determine OS name
case "${_uname_os}" in
    Linux*)     _osname=linux;;
    Darwin*)    _osname=darwin;;
    MINGW*)     _osname=windows;;
    *)          echo "UNSUPPORTED OS: ${_uname_os}" >&2; exit 1;;
esac

# Determine architecture
_arch=amd64
if [ "${_uname_arch}" = "aarch64" ] || [ "${_uname_arch}" = "arm64" ]; then
  _arch=arm64
fi

# Backup existing cosign binary if it exists
if [ -f /usr/bin/cosign ]; then
  mv /usr/bin/cosign /usr/bin/cosign.bak
fi

# Download and install cosign
echo "Downloading cosign for ${_osname}-${_arch}..."
curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-${_osname}-${_arch}"
mv "cosign-${_osname}-${_arch}" /tmp/cosign
chmod +x /tmp/cosign
mv /tmp/cosign /usr/bin/cosign

echo "Cosign installed successfully to /usr/bin/cosign"
