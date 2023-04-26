#
# Docker helper
#

no_cache=false
os=bullseye

all:
	sudo docker build --no-cache=true -t="obiba/obiba-r:$(tag)-$(os)" . && \
		sudo docker build -t="obiba/obiba-r:$(tag)" . && \
		sudo docker build -t="obiba/obiba-r:latest" . && \
		sudo docker image push obiba/obiba-r:$(tag)-$(os) && \
		sudo docker image push obiba/obiba-r:$(tag) && \
		sudo docker image push obiba/obiba-r:latest

# Build Docker image
build:
	sudo docker build --no-cache=$(no_cache) -t="obiba/obiba-r:$(tag)" .

push:
	sudo docker image push obiba/obiba-r:$(tag)
