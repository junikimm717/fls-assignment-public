#!/usr/bin/env bash

set -e

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR"

IMAGE="ghcr.io/junikimm717/fls-grading/dev"
CONTAINER="test-builder-lfs"

if ! docker image inspect "$IMAGE" > /dev/null 2>&1; then
  docker build -t "$IMAGE:latest" .
fi

mkdir -p ../dist/{busybox,kernel,user,image}
if ! docker container inspect "$CONTAINER" >/dev/null 2>&1; then
  docker run -dt --rm --name "$CONTAINER" \
    -v ..:/workspace \
    "$IMAGE:latest"
fi

docker exec \
  -e DIST="/dist" \
  -e SRC="/src" \
  -it \
  "$CONTAINER" /build-all-stages.sh

docker cp "$CONTAINER":/dist/bootable.img "../dist/bootable.img"
