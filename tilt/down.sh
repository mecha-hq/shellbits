#!/bin/sh

set -e
set -o errexit -o nounset

# Variables

PROJECT_NAME="${TILT_DOWN_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"
FORCE="${TILT_DOWN_FORCE:-${TILT_FORCE:-0}}"

while :; do
    case ${1:-} in
        --force)                  # Takes an option argument, ensuring it has been specified.
            FORCE=1
            ;;
        --)                       # End of all options.
            shift
            break
            ;;
        *)                        # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

# Exec

echo "Deleting cluster..."
docker rm -f "${PROJECT_NAME}-control-plane"

if [ "${FORCE}" -eq "1" ]; then
  echo "Deleting local registry..."
  docker rm -f "${PROJECT_NAME}-registry"
else
  echo "Stopping local registry..."
  docker stop "${PROJECT_NAME}-registry"
fi

echo "Done."
