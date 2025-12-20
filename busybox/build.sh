#!/usr/bin/env bash

set -euo pipefail

# The grader will run this script to build up the busybox binary.

DIR="$(realpath "$(dirname "$0" )" )"

# copy the init script to the rootfs.
cp "$DIR/init" "$ROOTFS/init"

# some convenience variables
MUSL_SRC="$SRC/musl"
BUSYBOX_SRC="$SRC/busybox"
