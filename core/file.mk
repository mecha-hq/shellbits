FILE_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
FILE_FILELINT_IMAGE?=cytopia/file-lint:latest-0.8

include ${FILE_SHELLBITS_DIR}/utils.mk

.PHONY: file-lint
file-lint:
	@${FILE_SHELLBITS_DIR}/file/lint/main.sh

.PHONY: file-lint-docker
file-lint-docker:
	$(call docker-run,"${FILE_SHELLBITS_DIR}/file/lint/main.sh","${FILE_FILELINT_IMAGE}")

.PHONY: file-format
file-format:
	@${FILE_SHELLBITS_DIR}/file/format/main.sh

.PHONY: file-format-docker
file-format-docker:
	$(call docker-run,"${FILE_SHELLBITS_DIR}/file/format/main.sh","${FILE_FILELINT_IMAGE}")
