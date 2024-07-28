COSIGN_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: cosign-install-latest
cosign-install-latest:
	@${COSIGN_SHELLBITS_DIR}/cosign/install-latest.sh
