COSIGN_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: cosign-test-sign
cosign-test-sign:
	@${COSIGN_SHELLBITS_DIR}/cosign/test-sign/main.sh $1
