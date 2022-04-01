#!/usr/bin/env bash

set -e
source ~/.profile
echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USER" --password-stdin
