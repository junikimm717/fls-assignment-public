#!/usr/bin/env bash

set -e

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR"

IMAGE="lfs-course-builder"
docker build -t "$IMAGE:latest" .
