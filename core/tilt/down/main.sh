#!/bin/sh

set -e
set -u

# Variables

_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Cleanup function to unset all environment variables
cleanup_env() {
    # Common variables
    unset TILT_PROJECT_NAME
    unset TILT_FORCE
    # Down-specific variables
    unset TILT_DOWN_PROJECT_NAME
    unset TILT_DOWN_FORCE
}

# Set trap to cleanup on script exit
trap cleanup_env EXIT

# Source environment variables
. "${_script_dir}/env.sh"

# Set private variables using the now-loaded env vars
_project_name="${TILT_DOWN_PROJECT_NAME:-${TILT_PROJECT_NAME:-$(basename $(pwd))}}"
_force="${TILT_DOWN_FORCE:-${TILT_FORCE:-0}}"

while :; do
    case ${1:-} in
        --force)                  # Takes an option argument, ensuring it has been specified.
            _force=1
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
docker rm -f "${_project_name}-control-plane"

if [ "${_force}" -eq "1" ]; then
  echo "Deleting local registry..."
  docker rm -f "${_project_name}-registry"
else
  echo "Stopping local registry..."
  docker stop "${_project_name}-registry"
fi

echo "Done."
