FROM buildpack-deps:stretch
MAINTAINER Maciej Stasieluk <maciej.stasieluk@vazco.eu>

# Install dependecies
RUN set -x && \
    apt-get update && \
    apt-get install -y \
        # Basic stuff
        curl \
        unzip \
        wget \
        # bcrypt and friends
        bcrypt \
        make \
        g++ \
        python

# Create Meteor user and group
RUN groupadd meteor && useradd --gid meteor --shell /bin/bash --create-home meteor

# Install latest (at the time of the build) Meteor version
USER meteor
RUN set -x && curl https://raw.githubusercontent.com/auterium/meteor-pipelines/master/install.sh | sh

# Fix for missing locales (https://github.com/meteor/meteor/issues/4019)
RUN echo "export LC_ALL=C.UTF-8" >> ~/.bashrc
USER root

# Link Meteor to be available globally
RUN ln -s /home/meteor/.meteor/meteor /usr/local/bin/

# Clean excessive files
RUN set -x && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*

# Switch back to Meteor user
USER meteor
WORKDIR /home/meteor

# Healthcheck and version stats
RUN meteor --version
