GOLANG_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: check-deps-upgrades
check-deps-upgrades:
	@${GOLANG_SHELLBITS_DIR}/golang/check-deps-upgrades.sh

.PHONY: format
format:
	@${GOLANG_SHELLBITS_DIR}/golang/format.sh

.PHONY: install-tools
install-tools:
	@${GOLANG_SHELLBITS_DIR}/golang/install-tools.sh

.PHONY: lint
lint:
	@${GOLANG_SHELLBITS_DIR}/golang/lint.sh

.PHONY: show-coverage
show-coverage:
	@${GOLANG_SHELLBITS_DIR}/golang/show-coverage.sh

.PHONY: test
test:
	@${GOLANG_SHELLBITS_DIR}/golang/test.sh

.PHONY: test-e2e
test-e2e:
	@${GOLANG_SHELLBITS_DIR}/golang/test-e2e.sh

.PHONY: test-integration
test-integration:
	@${GOLANG_SHELLBITS_DIR}/golang/test-integration.sh

.PHONY: test-unit
test-unit:
	@${GOLANG_SHELLBITS_DIR}/golang/test-unit.sh

.PHONY: upgrade-deps
upgrade-deps:
	@${GOLANG_SHELLBITS_DIR}/golang/upgrade-deps.sh
