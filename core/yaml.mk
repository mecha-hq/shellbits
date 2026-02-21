YAML_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
YAML_YAMLLINT_IMAGE?=cytopia/yamllint:1

include ${YAML_SHELLBITS_DIR}/utils.mk

.PHONY: yaml-lint
yaml-lint:
	@${YAML_SHELLBITS_DIR}/yaml/lint/main.sh

.PHONY: yaml-lint-docker
yaml-lint-docker:
	$(call docker-run,"${YAML_SHELLBITS_DIR}/yaml/lint/main.sh","${YAML_YAMLLINT_IMAGE}")

.PHONY: yaml-format
yaml-format:
	@${YAML_SHELLBITS_DIR}/yaml/format/main.sh

.PHONY: yaml-format-docker
yaml-format-docker:
	$(call docker-run,"${YAML_SHELLBITS_DIR}/yaml/format/main.sh","${YAML_YAMLLINT_IMAGE}")
