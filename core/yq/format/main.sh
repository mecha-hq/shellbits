#!/bin/sh

set -eu

# Variables
_script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Source environment variables
. "${_script_dir}/env.sh"

# Main execution function
main() {
	# Find all YAML files and format them using yq
	# Uses YQ_FORMAT_FLAGS from env.sh for configuration
	find . \( -name "*.yaml" -o -name "*.yml" \) -type f -exec yq eval ${YQ_FORMAT_FLAGS} -i {} \;
}

# Execute main function
main
