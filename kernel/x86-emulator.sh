#!/bin/sh

KERNEL="$DIST/linuximage"

qemu-system-x86_64 \
  -machine q35 \
  -m 1024 \
  -kernel "$KERNEL" \
  -nographic \
  -no-reboot \
  -serial mon:stdio \
  -append "console=ttyS0" \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -append "console=ttyS0 earlyprintk=serial,ttyS0 loglevel=8" \
