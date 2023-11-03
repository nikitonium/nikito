FROM debian:stretch
LABEL maintainer="Nikito Developers <dev@nikitonium.com>"
LABEL description="Dockerised NikitoCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
