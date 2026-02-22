MKFILE_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
MKFILE_MAKEFILELINT_IMAGE?=cytopia/checkmake:latest-0.5

.PHONY: makefile-lint
makefile-lint:
	@${MKFILE_SHELLBITS_DIR}/mkfile/lint/main.sh

.PHONY: makefile-lint-docker
makefile-lint-docker:
	$(call docker-run,"${MKFILE_SHELLBITS_DIR}/mkfile/lint/main.sh","${MKFILE_MAKEFILELINT_IMAGE}")
