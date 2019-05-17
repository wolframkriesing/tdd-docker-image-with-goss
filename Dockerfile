FROM golang

# Goss installation, as the website suggests.
# https://github.com/aelsabbahy/goss#installation
RUN curl -fsSL https://goss.rocks/install | sh

# install docker in here, by following instructions given at https://docs.docker.com/install/linux/docker-ce/debian/
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce
