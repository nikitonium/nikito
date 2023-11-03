#!/usr/bin/env bash

export LC_ALL=C

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/.. || exit

DOCKER_IMAGE=${DOCKER_IMAGE:-nikito/nikitod-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/nikitod docker/bin/
cp $BUILD_DIR/src/nikito-cli docker/bin/
cp $BUILD_DIR/src/nikito-tx docker/bin/
strip docker/bin/nikitod
strip docker/bin/nikito-cli
strip docker/bin/nikito-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
