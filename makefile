.ONESHELL:
.SILENT:
SHELL := /bin/bash
IMAGE_NAME ?= wsl-ubuntu
BUILD_TOOL ?= podman

validate-tool:
	if ! podman_loc="`type -p podman`" || [[ -z "$$podman_loc" ]]; then
		if ! docker_loc="`type -p docker`" || [[ -z "$$docker_loc" ]]; then
			>&2 echo "Cannot find podman and docker either."
			exit 1
		else
			echo "Found docker command, we'll use docker to build image."
			BUILD_TOOL := docker
		fi
	else
		echo "Found podman command, we'll use podman to build image."
		BUILD_TOOL := podman
	fi

build: validate-tool
	podman build --tag="$$IMAGE_NAME:latest" .
	podman run "$$IMAGE_NAME:latest" ls / > /dev/null

	CONTAINER_ID=`podman container ls -a | grep -i "$$IMAGE_NAME" | cut -d' ' -f1`
	podman export "$$CONTAINER_ID" | zstd -5 > "$$IMAGE_NAME.tar.gz"
	podman container rm "$$CONTAINER_ID"

clean: validate-tool
	podman image rm "$$IMAGE_NAME:latest"
	rm -f ${IMAGE_NAME}.tar.gz