#!/usr/bin/env bash

set -e

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USER" --password-stdin
