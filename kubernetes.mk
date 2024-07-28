KUBERNETES_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: generate-ts-client
generate-ts-client:
	@${KUBERNETES_SHELLBITS_DIR}/kubernetes/generate-ts-client.sh
