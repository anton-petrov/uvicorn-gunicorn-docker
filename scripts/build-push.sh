#!/usr/bin/env bash

set -e

use_tag="antonapetrov/uvicorn-gunicorn:$NAME"
use_dated_tag="${use_tag}-$(date +%F)"

DOCKERFILE="$NAME"

if [ "$NAME" == "latest" ] ; then
    DOCKERFILE="python3.9"
fi

bash scripts/docker-login.sh

# docker buildx create --use --platform linux/arm64/v8,linux/amd64,linux/ppc64le
docker buildx build --platform linux/amd64,linux/arm64 -t "$use_tag" --file "./docker-images/${DOCKERFILE}.dockerfile" --push "./docker-images/"

# docker tag "$use_tag"
