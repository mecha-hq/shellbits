MARKDOWN_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
MARKDOWN_MARKDOWNLINT_IMAGE?=davidanson/markdownlint-cli2:v0.6.0

.PHONY: markdown-lint
markdown-lint:
	@${MARKDOWN_SHELLBITS_DIR}/markdown/lint.sh

.PHONY: markdown-lint-docker
markdown-lint-docker:
	$(call docker-run,"${MARKDOWN_SHELLBITS_DIR}/markdown/lint-dockerfile.sh","${MARKDOWN_MARKDOWNLINT_IMAGE}")

.PHONY: markdown-format
markdown-format:
	@${MARKDOWN_SHELLBITS_DIR}/markdown/format.sh

.PHONY: markdown-format-docker
markdown-format-docker:
	$(call docker-run,"${MARKDOWN_SHELLBITS_DIR}/markdown/format-dockerfile.sh","${MARKDOWN_MARKDOWNLINT_IMAGE}")
