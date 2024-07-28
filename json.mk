JSON_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
JSON_JSONLINT_IMAGE?=cytopia/jsonlint:1.6.0

include ${JSON_SHELLBITS_DIR}/utils.mk

.PHONY: json-lint
json-lint:
	@${DIR}/json/lint.sh

.PHONY: json-lint-docker
json-lint-docker:
	$(call docker-run,"${JSON_SHELLBITS_DIR}/json/lint.sh","${JSON_JSONLINT_IMAGE}")

.PHONY: json-format
json-format:
	@${DIR}/json/format.sh

.PHONY: json-format-docker
json-format-docker:
	$(call docker-run,"${JSON_SHELLBITS_DIR}/json/format.sh","${JSON_JSONLINT_IMAGE}")
