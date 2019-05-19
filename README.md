# TDD your next docker container

This is the repo that accompanies [the talk "TDD your next docker container"][1] given at [DevOpsDays Poznań May 20, 2019][2].

## TL;DR
This repository is a step by step development of a [dgoss][3]-based TDDing approach to a build a docker image. Just follow each commit and it's commit message and it should enable the reader to follow the steps how to build a docker image that tests another docker image, the Image Under Test (IUT), using declarative tests powered by [goss][4].

## Usage
- `./run.sh` runs the tests, which are testing the docker image itself that is used for running the tests
- `./run.sh /bin/bash` to open a bash shell inside the container that has `goss` and `dgoss` installed
  running this command, you also have the `goss.yaml` file mounted into the container so you can play with the tests

## The tools used
**goss:** "Goss is a YAML based [serverspec][8] alternative tool for validating a server’s configuration. It eases the process of writing tests by allowing the user to generate tests from the current system state. Once the test suite is written they can be executed, waited-on, or served as a health endpoint." – from [goss README][6]

**dgoss:** "dgoss is a convenience wrapper around goss that aims to bring the simplicity of goss to docker containers." – from the [dgoss README][7]

## Decisions
See the [Architecture Decision Records (ADRs)][5] for the decisions 
made in this repo and their reasoning. Eventually the change in decisions 
must be recorded there too.
The decisions taken are:
- Record architecture decisions using ADRs [ADR #0](./docs/adr/000-use-adrs.md)
- Goss as ServerSpec tool [ADR #1](./docs/adr/001-goss-as-serverspec.md)
- Do docker-in-docker via sockets [ADR #2](./docs/adr/002-docker-in-docker-via-sockets.md)

## What shall the IUT (image under test) do?
Now it becomes a bit recursive. Since I am not a local-install person, I need a docker image that has (d)goss installed. So this repo will show how to setup a docker container that has goss and dgoss installed (and now comes the recursive part) which will be used to mount the same docker image and test that those two are installed correctly.

## How?
In order to [TDD a docker container][9] we need an envirnonment that runs those tests. To have that we create an image that contains the environment for those tests. In this case we decided for dgoss, as opposed to other tools like ServerSpec, see ADR#1 for the decision.

For TDDing the actual production docker image, the IUT, which we want to use for our application eventually, we will use the before mentioned first image with goss in it. If we would run the IUT inside the first image, we would need [docker in docker][10] (dind). This is mentioned in multiple places to [NOT be such a good idea][11], even though there is a [dind docker image][7]. The alternative is also described [here][13] (by the dind author). This is the approach we try to follow with this repo.

## Tips, Tricks, Learnings

- When running `dgoss` on a Mac add `GOSS_FILES_STRATEGY=cp` before the command as documented in github issues of goss ([the issue][14] and [the solution][15]). For example like so: `GOSS_FILES_STRATEGY=cp dgoss edit -p 8080:80 nginx`

[1]: https://devopsdays.org/events/2019-poznan/program/wolfram-kriesing/
[2]: https://devopsdays.org/events/2019-poznan/welcome/
[3]: https://github.com/aelsabbahy/goss/tree/master/extras/dgoss
[4]: https://goss.rocks
[5]: ./docs/adr
[6]: https://github.com/aelsabbahy/goss#what-is-goss
[7]: https://github.com/aelsabbahy/goss/tree/master/extras/dgoss#dgoss
[8]: https://serverspec.org/
[9]: https://www.thoughtworks.com/radar/techniques/tdd-ing-containers
[10]: https://github.com/jpetazzo/dind
[11]: https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
[12]: https://hub.docker.com/_/docker/
[13]: https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/#the-solution
[14]: https://github.com/aelsabbahy/goss/issues/389
[15]: https://github.com/aelsabbahy/goss/issues/389#issuecomment-438500712
