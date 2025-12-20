# Filesystem image builder

Here you should have code that builds and assembles the final filesystem image.
The final filesystem should have two partitions:

1. The ESP (needs to be marked as such) contains the initramfs archive in
   `$DIST/archive.cpio.gz` along with the kernel from `$DIST/linuximage`. It
   MUST be of type FAT32 since that is the only filesystem accepted by the EFI
   firmware.
2. The root partition, formatted as an ext4 filesystem, contains all the
   contents of `$DIST/user` (root filesystem)

Your `./build.sh` script, which can call other programs (given they work no
matter in which directory one invokes the build script), must create separate
.img files for both the ESP and the root partition. It must then stitch those
two .img files together into a single bootable image file.

Please do not make the combined bootable image more than 500MB in size.

Hints:

1. To create a filesystem image, you should initialize a zeroed file of some
   specified size, then use `mkfs.ext4` or `mkfs.vfat` to actually initialize
   the filesystem.
2. For stitching the final partition together, it is recommended to use
   `sgdisk`, although you may use other tools as needed.
