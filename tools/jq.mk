JQ_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
JQ_IMAGE?=stedolan/jq:latest

include ${JQ_SHELLBITS_DIR}/utils.mk

.PHONY: jq-format
jq-format:
	@${JQ_SHELLBITS_DIR}/jq/format/main.sh

.PHONY: jq-format-docker
jq-format-docker:
	$(call docker-run,"${JQ_SHELLBITS_DIR}/jq/format/main.sh","${JQ_IMAGE}")