IMAGE_CREATED := $(shell date --rfc-3339=seconds)
#export DOCKER_BUILDKIT ?= 1
COMPILER_VERSION := 5.3.0
REVISION := $(shell git rev-list -n 1 --abbrev-commit --abbrev=8 HEAD)
TAG := $(COMPILER_VERSION)-$(REVISION)

image:
	docker build\
		--build-arg REVISION=$(REVISION)\
		--build-arg COMPILER_VERSION=$(COMPILER_VERSION)\
		--build-arg IMAGE_CREATED="$(IMAGE_CREATED)"\
		--tag rbjorklin/techempower-ocaml-image:$(TAG)\
		--file Dockerfile\
		.

push:
	docker push rbjorklin/techempower-ocaml-image:$(TAG)
