MISE_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: mise-update-tools
mise-update-tools:
	@${MISE_SHELLBITS_DIR}/mise/update-tools.sh
