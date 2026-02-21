#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables

. "${_script_dir}/env.sh"

# Parse flags

while :; do
    case ${1:-} in
        -f|--force)
            TILT_DOWN_FORCE=1
            ;;
        --) # End of all options.
            shift
            break
            ;;
        *)  # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

# Exec

echo "Deleting cluster..."
docker rm -f "${TILT_DOWN_PROJECT_NAME}-control-plane"

if [ "${TILT_DOWN_FORCE}" -eq "1" ]; then
  echo "Deleting local registry..."
  docker rm -f "${TILT_DOWN_PROJECT_NAME}-registry"
else
  echo "Stopping local registry..."
  docker stop "${TILT_DOWN_PROJECT_NAME}-registry"
fi

echo "Done."
