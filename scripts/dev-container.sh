#!/bin/sh

set -e

if test -z "$PART"; then
  echo "\$LAB must be defined"
  exit 1
fi

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR"

IMAGE="ghcr.io/junikimm717/fls-grading/dev"
CONTAINER="$PART-builder-lfs"

if ! docker image inspect "$IMAGE" > /dev/null 2>&1; then
  docker pull "$IMAGE"
fi

if ! docker container inspect "$CONTAINER" >/dev/null 2>&1; then
  docker run -dt --rm --name "$CONTAINER" \
    -v ../"$PART":/workspace \
    -v ../dist:/dist \
    "$IMAGE:latest"
fi

mkdir -p ../dist/"$PART"
docker exec \
  -e ROOTFS="/dist/$PART" \
  -e DIST="/dist" \
  -e SRC="/src" \
  -it \
  "$CONTAINER" /devshell.sh
