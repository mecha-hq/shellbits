YAML_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
YAML_YAMLLINT_IMAGE?=cytopia/yamllint:1

include ${YAML_SHELLBITS_DIR}/utils.mk

.PHONY: yaml-lint
yaml-lint:
	@${DIR}/yaml/lint.sh

.PHONY: yaml-lint-docker
yaml-lint-docker:
	$(call docker-run,"${YAML_SHELLBITS_DIR}/yaml/lint.sh","${YAML_YAMLLINT_IMAGE}")

.PHONY: yaml-format
yaml-format:
	@${DIR}/yaml/format.sh

.PHONY: yaml-format-docker
yaml-format-docker:
	$(call docker-run,"${YAML_SHELLBITS_DIR}/yaml/format.sh","${YAML_YAMLLINT_IMAGE}")
