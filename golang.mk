.PHONY: check-deps-upgrades format install-tools lint show-coverage test test-e2e test-integration test-unit upgrade-deps

check-deps-upgrades:
	@golang/check-deps-upgrades.sh

format:
	@golang/format.sh

install-tools:
	@golang/install-tools.sh

lint:
	@golang/lint.sh

show-coverage:
	@golang/show-coverage.sh

test:
	@golang/test.sh

test-e2e:
	@golang/test-e2e.sh

test-integration:
	@golang/test-integration.sh

test-unit:
	@golang/test-unit.sh

upgrade-deps:
	@golang/upgrade-deps.sh
