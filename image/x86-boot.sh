#!/bin/sh

IMAGE="$DIST/bootable.img"

qemu-system-x86_64 \
  -machine q35 \
  -m 1024 \
  -nographic \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.fd \
  -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS_4M.fd \
  -drive if=virtio,format=raw,file="$IMAGE" \
  -serial mon:stdio \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
