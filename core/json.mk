JSON_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
JSON_JSONLINT_IMAGE?=cytopia/jsonlint:1.6.0

include ${JSON_SHELLBITS_DIR}/utils.mk

.PHONY: json-lint
json-lint:
	@${JSON_SHELLBITS_DIR}/json/lint/main.sh

.PHONY: json-lint-docker
json-lint-docker:
	$(call docker-run,"${JSON_SHELLBITS_DIR}/json/lint/main.sh","${JSON_JSONLINT_IMAGE}")

.PHONY: json-format
json-format:
	@${JSON_SHELLBITS_DIR}/json/format/main.sh

.PHONY: json-format-docker
json-format-docker:
	$(call docker-run,"${JSON_SHELLBITS_DIR}/json/format/main.sh","${JSON_JSONLINT_IMAGE}")
