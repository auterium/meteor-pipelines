FROM node:7.10.0-wheezy
MAINTAINER Marc Enriquez

# Install meteor v 1.2.0.2
RUN curl -sL https://raw.githubusercontent.com/auterium/meteor-pipelines/master/install.sh | sed s/--progress-bar/-sL/g | /bin/sh
RUN export METEOR_ALLOW_SUPERUSER=true

RUN adduser --disabled-password --gecos '' docker_meteor
USER docker_meteor