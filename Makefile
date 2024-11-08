#
# Docker helper
#

no_cache=true
os=noble
java=21

all:
	sudo docker build --no-cache=true -t="obiba/obiba-r:$(tag)-java-$(java)-$(os)" . && \
		sudo docker tag "obiba/obiba-r:$(tag)-java-$(java)-$(os)" "obiba/obiba-r:$(tag)-$(os)" && \
		sudo docker tag "obiba/obiba-r:$(tag)-java-$(java)-$(os)" "obiba/obiba-r:$(tag)" && \
		sudo docker image push obiba/obiba-r:$(tag)-java-$(java)-$(os) && \
		sudo docker image push obiba/obiba-r:$(tag)-$(os) && \
		sudo docker image push obiba/obiba-r:$(tag)

# Build Docker image
build:
	sudo docker build --pull --no-cache=$(no_cache) -t="obiba/obiba-r:$(tag)" . --progress=plain

push:
	sudo docker image push obiba/obiba-r:$(tag)
