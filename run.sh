#!/usr/bin/env bash

set -e

docker build -t tdd-docker-image -f Dockerfile .

docker run --rm -it \
	--name tdd-docker-image \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	tdd-docker-image $1
