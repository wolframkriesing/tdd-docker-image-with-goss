#!/usr/bin/env bash

set -e

docker build -t tdd-docker-image -f Dockerfile .

docker run --rm -it \
	--name tdd-docker-image \
	--volume "$(pwd)":/go \
	tdd-docker-image \
	/bin/bash
