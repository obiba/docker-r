#
# Docker helper
#

no_cache=false

# Build Docker image
build:
	sudo docker build --no-cache=$(no_cache) -t="obiba/obiba-r:snapshot" .

build-36:
	cd 3.6 && sudo docker build --no-cache=$(no_cache) -t="obiba/obiba-r:3.6-snapshot" .
