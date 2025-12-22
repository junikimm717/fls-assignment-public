#!/usr/bin/env bash

set -euo pipefail

export DIST
export SRC

cd /workspace
ROOTFS="/dist/busybox" ./busybox/build.sh
ROOTFS="/dist/kernel" ./kernel/build.sh
ROOTFS="/dist/user" ./user/build.sh
ROOTFS="/dist/image" ./image/build.sh
