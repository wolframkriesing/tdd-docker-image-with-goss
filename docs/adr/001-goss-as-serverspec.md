# 1. Goss as ServerSpec tool

## Status

Accepted

## Context

In order to test the docker container we need to build, we want to use a tool
such as [ServerSpec][1] or [goss][2].

## Decision

ServerSpec was the one Mario Fernandez introduced in his talk "TDD for infrastructure". On the [TDDing containers][3] page goss is linked, which is more declarative, not so much programming as ServerSpec (which is basically rspec tests).

This project uses goss. Basically for the following reasons:
1) much faster test execution (due to Golang I believe)
2) much smaller environment footprint (just a go runtime, goss, and a bit on top)
3) easy generation of initial test set (from an existing docker container)

## Consequences

* CON: since tests can be generated, the TDDing/test-first requires discipline (to not fall victim to test-after)
* CON: only what the DSL provides is available (ServerSpec/rspec everything can be built/programmed)
* PRO: the required environment is much smaller, setting up a ruby/ServerSpec env might be huge and error prone, see ["A Docker image that can run docker-in-docker and has ruby installed"][4] 
  ([quote from the project's README][5])
* PRO: changes in docker containers are documented/tested (yeah)

[1]: https://serverspec.org/
[2]: https://goss.rocks
[3]: https://www.thoughtworks.com/radar/techniques/tdd-ing-containers
[4]: https://github.com/sirech/example-concourse-pipeline/blob/master/serverspec/Dockerfile.serverspec
[5]: https://github.com/sirech/example-concourse-pipeline