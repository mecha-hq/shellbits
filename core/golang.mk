GOLANG_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: check-deps-upgrades
check-deps-upgrades:
	@${GOLANG_SHELLBITS_DIR}/golang/check-deps-upgrades/main.sh

.PHONY: format
format:
	@${GOLANG_SHELLBITS_DIR}/golang/format/main.sh

.PHONY: install-tools
install-tools:
	@${GOLANG_SHELLBITS_DIR}/golang/install-tools/main.sh

.PHONY: lint
lint:
	@${GOLANG_SHELLBITS_DIR}/golang/lint/main.sh

.PHONY: show-coverage
show-coverage:
	@${GOLANG_SHELLBITS_DIR}/golang/show-coverage/main.sh

.PHONY: test
test:
	@${GOLANG_SHELLBITS_DIR}/golang/test/main.sh

.PHONY: test-e2e
test-e2e:
	@${GOLANG_SHELLBITS_DIR}/golang/test-e2e/main.sh

.PHONY: test-integration
test-integration:
	@${GOLANG_SHELLBITS_DIR}/golang/test-integration/main.sh

.PHONY: test-unit
test-unit:
	@${GOLANG_SHELLBITS_DIR}/golang/test-unit/main.sh

.PHONY: upgrade-deps
upgrade-deps:
	@${GOLANG_SHELLBITS_DIR}/golang/upgrade-deps/main.sh
