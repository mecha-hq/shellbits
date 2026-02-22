HELP_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include ${HELP_SHELLBITS_DIR}/../utils.mk

.PHONY: help
help:
	@${HELP_SHELLBITS_DIR}/help/help.sh $(MAKEFILE_LIST)
