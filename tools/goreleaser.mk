GORELEASER_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: build
build:
	@${GORELEASER_SHELLBITS_DIR}/goreleaser/build/main.sh

.PHONY: release
release:
	@${GORELEASER_SHELLBITS_DIR}/goreleaser/release/main.sh
