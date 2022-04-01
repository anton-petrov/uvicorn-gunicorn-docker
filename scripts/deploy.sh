#!/usr/bin/env bash

set -e
set -x

./scripts/build-push-all.sh

./scripts/trigger-children.sh
