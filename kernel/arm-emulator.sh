#!/bin/sh

KERNEL="$DIST/linuximage"

qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a72 \
  -m 1024 \
  -kernel "$KERNEL" \
  -nographic \
  -serial mon:stdio \
  -no-reboot \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -append "console=ttyAMA0 earlyprintk=serial,ttyAMA0 loglevel=8" \
