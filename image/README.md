# Filesystem image builder

You will implement shell code that builds and assembles the final filesystem
image. The final disk image should have two partitions:

1. The ESP (needs to be marked as such) contains the initramfs archive in
   `$DIST/archive.cpio.gz` along with the kernel from `$DIST/linuximage`. It
   MUST have a FAT32 filesystem since that is the only filesystem readable by the EFI
   firmware.
2. The root partition, containing an ext4 filesystem, contains all the contents
   of `$DIST/user` (root filesystem)

Your `./build.sh` script, which can call other programs (given they work no
matter in which directory one invokes the build script), must create separate
.img files for both the ESP and the root partition. It must then stitch those
two .img files together into a single bootable image file.

Please feel free to write additional scripts to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.

Please do not have the combined bootable image be more than 200MB in size.

## Container Layout

The container that you'll get when running `../docker/image-container.sh`
(assuming this is your working directory) is laid out as follows:

- This directory is mapped to `/workspace`
- The `../dist` directory is mapped to `/dist` (which is also equal to the value
  of the `$DIST` environment variable)
- The `/src` directory (provided in the container as the `$SRC` environment
  variable) contains source trees for all the programs you will need to build

## Hints

1. To create a filesystem image, you should initialize a zeroed file of some
   specified size, then use `mkfs.ext4` (rootfs) or `mkfs.vfat` (esp) to
   actually initialize the filesystem.
2. For stitching the final partition together, it is recommended to use
   `sgdisk`, although you may use other tools as needed.

If you want to test your image, below is the code we will use for grading:

```bash
# Assume $IMAGE is the path to your bootable image.

# if you built an x86 image:
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
# if you built an arm image (only difference is firmware and board):
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
```
