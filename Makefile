#
# Docker helper
#

tag=snapshot
no_cache=true

# Build Docker image
build:
	docker build --pull --no-cache=$(no_cache) -t="obiba/obiba-r:$(tag)" . --progress=plain

push:
	docker image push obiba/obiba-r:$(tag)
