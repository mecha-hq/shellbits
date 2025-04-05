SHELL_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SHELL_SHELLCHECK_IMAGE?=koalaman/shellcheck:v0.9.0
SHELL_SHFMT_IMAGE?=mvdan/shfmt:v3

include ${SHELL_SHELLBITS_DIR}/utils.mk

.PHONY: shell-lint
shell-lint:
	@${SHELL_SHELLBITS_DIR}/shell/lint.sh

.PHONY: shell-lint-docker
shell-lint-docker:
	$(call docker-run,"${SHELL_SHELLBITS_DIR}/shell/lint.sh","${SHELL_SHELLCHECK_IMAGE}")

.PHONY: shell-format
shell-format:
	@${SHELL_SHELLBITS_DIR}/shell/format.sh

.PHONY: shell-format-docker
shell-format-docker:
	$(call docker-run,"${SHELL_SHELLBITS_DIR}/shell/format.sh","${SHELL_SHFMT_IMAGE}")
