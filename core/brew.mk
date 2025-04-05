BREW_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: brew-install-tools
brew-install-tools:
	@${BREW_SHELLBITS_DIR}/brew/install-tools.sh
