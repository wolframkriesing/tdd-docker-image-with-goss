# 2. Do docker-in-docker via sockets

## Status

Accepted

## Context

In order to test a docker image using goss, which requires golang we need a golang installation.
Which we want to have deterministic, so it is done inside a docker container.
That means the actual Image under Test (IUT) will be started from within another docker
container. That sounds like docker-in-docker hell.

## Decision

In [1] the how-to is described, which prevents to really do docker-in-docker, but
reuse the docker socket that the host machine uses. This way the docker containers
are spun up as sibling, not as children (which can cause problems).
This is done using `-v /var/run/docker.sock:/var/run/docker.sock` as argument to `docker run`.

## Consequences

- PRO: we don't need docker in docker
- CON: the host system's docker socket is used
- CON: one extra config to the `docker run` command is required

[1]: https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/