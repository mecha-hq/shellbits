DOCKER_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
DOCKER_HADOLINT_IMAGE?=hadolint/hadolint:v2.12.0-alpine

include ${DOCKER_SHELLBITS_DIR}/utils.mk

.PHONY: dockerfile-lint
dockerfile-lint:
	@${SHELLBITS_DIR}/docker/lint-dockerfile.sh

.PHONY: dockerfile-lint-docker
dockerfile-lint-docker:
	$(call docker-run,"${SHELLBITS_DIR}/file/lint-dockerfile.sh","${DOCKER_HADOLINT_IMAGE}")
