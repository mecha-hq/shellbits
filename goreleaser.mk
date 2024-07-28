GORELEASER_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: build
build:
	@${GORELEASER_SHELLBITS_DIR}/goreleaser/build.sh

.PHONY: release
release:
	@${GORELEASER_SHELLBITS_DIR}/goreleaser/release.sh
