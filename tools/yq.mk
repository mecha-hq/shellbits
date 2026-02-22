YQ_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
YQ_IMAGE?=mikefarah/yq:latest

include ${YQ_SHELLBITS_DIR}/utils.mk

.PHONY: yq-format
yq-format:
	@${YQ_SHELLBITS_DIR}/yq/format/main.sh

.PHONY: yq-format-docker
yq-format-docker:
	$(call docker-run,"${YQ_SHELLBITS_DIR}/yq/format/main.sh","${YQ_IMAGE}")