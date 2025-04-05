# $1: type
# $2: name
# $3: command
define find-exec
	@find . \
	-type $1 \
	-not -path "**/node_modules/**" \
	-not -path ".git" \
	-not -path ".github" \
	-not -path ".vscode" \
	-not -path ".idea" \
	-name $2 \
	-print0 | \
	xargs -I {} -0 sh -c $3
endef

# $1: script-dir
# $2: docker-image
define docker-run
	@docker run --rm \
		--volume $$(pwd):/data \
		--volume $1:/usr/local/bin/shellbit-run.sh \
		--workdir /data \
		--entrypoint /bin/sh \
		$2 \
		/usr/local/bin/shellbit-run.sh
endef

# check-variable-%: Check if the variable is defined.
check-variable-%:
	@[[ "${${*}}" ]] || (echo '*** Please define variable `${*}` ***' && exit 1)
