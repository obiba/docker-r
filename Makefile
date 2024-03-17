#
# Docker helper
#

no_cache=false
os=jammy
java=21

all:
	sudo docker build --no-cache=true -t="obiba/obiba-r:$(tag)-java-$(java)-$(os)" . && \
		sudo docker build -t="obiba/obiba-r:$(tag)" . && \
		sudo docker image push obiba/obiba-r:$(tag)-java-$(java)-$(os) && \
		sudo docker image push obiba/obiba-r:$(tag)

# Build Docker image
build:
	sudo docker build --no-cache=$(no_cache) -t="obiba/obiba-r:$(tag)" . --progress=plain

push:
	sudo docker image push obiba/obiba-r:$(tag)
