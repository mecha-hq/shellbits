HADOLINT_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
HADOLINT_IMAGE?=hadolint/hadolint:v2.12.0

include ${HADOLINT_SHELLBITS_DIR}/utils.mk

.PHONY: hadolint-lint
hadolint-lint:
	@${HADOLINT_SHELLBITS_DIR}/hadolint/lint/main.sh

.PHONY: hadolint-lint-docker
hadolint-lint-docker:
	$(call docker-run,"${HADOLINT_SHELLBITS_DIR}/hadolint/lint/main.sh","${HADOLINT_IMAGE}")