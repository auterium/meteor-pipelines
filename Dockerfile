FROM node:7.10.0-wheezy
MAINTAINER Marc Enriquez

# Install mup
RUN npm install -g mup
# Install meteor v 1.2.0.2
RUN curl https://raw.githubusercontent.com/auterium/meteor-pipelines/master/install.sh | sh
RUN export METEOR_ALLOW_SUPERUSER=true

RUN adduser --disabled-password --gecos '' docker_meteor
USER docker_meteor