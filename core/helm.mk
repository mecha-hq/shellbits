HELM_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
HELM_CHART_TESTING_IMAGE?=quay.io/helmpack/chart-testing:v3.7.0

.PHONY: helm-lint
helm-lint:
	@${HELM_SHELLBITS_DIR}/helm/lint/main.sh

.PHONY: helm-lint-docker
helm-lint-docker:
	$(call docker-run,"${HELM_SHELLBITS_DIR}/helm/lint/main.sh","${CHART_TESTING_IMAGE}")

.PHONY: helm-template
helm-template:
	@${HELM_SHELLBITS_DIR}/helm/template/main.sh

.PHONY: helm-template-docker
helm-template-docker:
	$(call docker-run,"${HELM_SHELLBITS_DIR}/helm/template/main.sh","${TODO_IMAGE}")

.PHONY: helm-install
helm-install:
	@${HELM_SHELLBITS_DIR}/helm/install/main.sh

.PHONY: helm-install-docker
helm-install-docker:
	$(call docker-run,"${HELM_SHELLBITS_DIR}/helm/install/main.sh","${TODO_IMAGE}")
