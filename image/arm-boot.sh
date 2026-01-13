#!/bin/sh

IMAGE="$DIST/bootable.img"

qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a72 \
  -m 1024 \
  -nographic \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd \
  -drive if=pflash,format=raw,file=/usr/share/AAVMF/AAVMF_VARS.fd \
  -drive if=virtio,format=raw,file="$IMAGE" \
  -serial mon:stdio \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0
