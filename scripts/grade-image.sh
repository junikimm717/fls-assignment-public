#!/bin/sh

set -e

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR"

BOOTABLE="$(realpath "$DIR/../dist/bootable.img")"

if ! test -f "$BOOTABLE"; then
  echo "There is no bootable disk image at $BOOTABLE!"
  exit 1
fi

IMAGE="ghcr.io/junikimm717/fls-grading/grader"

if ! docker image inspect "$IMAGE" > /dev/null 2>&1; then
  docker pull "$IMAGE"
fi

docker run \
  --rm -it \
  -v "$(dirname "$BOOTABLE")":/dist \
  "$IMAGE" \
  /grade.py /dist/bootable.img
