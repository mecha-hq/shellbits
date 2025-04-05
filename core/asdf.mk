ASDF_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: asdf-add-plugins
asdf-add-plugins:
	@${ASDF_SHELLBITS_DIR}/asdf/add-plugins.sh

.PHONY: asdf-update-tools
asdf-update-tools:
	@${ASDF_SHELLBITS_DIR}/asdf/update-tools.sh
