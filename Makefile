.PHONY: images test build start

VERSION = 1.0.0
SERVICE = jenca-gui

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# build the docker images
# the dev version includes development node modules
images:
	docker build -t jenca-cloud/$(SERVICE):latest .
	docker rmi jenca-cloud/$(SERVICE):$(VERSION)
	docker tag jenca-cloud/$(SERVICE):latest jenca-cloud/$(SERVICE):$(VERSION)

test:
	docker run -ti --rm \
		jenca-cloud/$(SERVICE):$(VERSION) test

build:
	docker run -ti --rm \
		-v $(ROOT_DIR)/dist:/app/dist \
		jenca-cloud/$(SERVICE):$(VERSION) build

start:
	docker run -ti --rm \
		-p 80:3002 \
		jenca-cloud/$(SERVICE):$(VERSION) start