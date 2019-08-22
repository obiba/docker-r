#
# Docker helper
#

no_cache=false

# Build Docker image
build:
	sudo docker build --no-cache=$(no_cache) -t="obiba/r:snapshot" .

build-version:
	sudo docker build --no-cache=$(no_cache) -t="obiba/r:$(version)" $(version)
