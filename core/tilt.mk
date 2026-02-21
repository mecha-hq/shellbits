TILT_SHELLBITS_DIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: tilt-down
tilt-down:
	@${TILT_SHELLBITS_DIR}/tilt/down/main.sh \
	   $$([ "${TILT_DOWN_FORCE:-${TILT_FORCE:-${FORCE:-0}}}" -eq 1 ] && echo --force)

.PHONY: tilt-start
tilt-start:
	@${TILT_SHELLBITS_DIR}/tilt/start/main.sh

.PHONY: tilt-stop
tilt-stop:
	@${TILT_SHELLBITS_DIR}/tilt/stop/main.sh

.PHONY: tilt-up
tilt-up:
	@${TILT_SHELLBITS_DIR}/tilt/up/main.sh \
	   $$([ "${TILT_UP_FORCE:-${TILT_FORCE:-${FORCE:-0}}}" -eq 1 ] && echo --force)
