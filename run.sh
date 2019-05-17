#!/usr/bin/env bash

docker build -t tdd-docker-image -f Dockerfile .

docker run --rm -it \
	--name tdd-docker-image \
	tdd-docker-image \
	/bin/bash
