.PHONY: build release

build:
	@goreleaser/build.sh

release:
	@goreleaser/release.sh
