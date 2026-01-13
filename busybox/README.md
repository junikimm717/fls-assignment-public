# Busybox

To start this lab, `cd` to this directory and run
`../scripts/busybox-container.sh` to get a shell into the docker container for
this lab.

The goal of this assignment is to generate a minimal root filesystem that can be
used as an initramfs image. To do this, you will need to install musl libc,
busybox, and the linux kernel headers, followed by generating a proper initramfs
cpio image at `$DIST/archive.cpio.gz`.

It is recommended to use the variable `$ROOTFS` instead of `/dist/busybox` when
describing your installation paths for the build script. The directory
`$SRC/busybox` contains the copy of the busybox source code that you should use.

Please feel free to write **additional scripts** to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.

## Container Layout

The container that you'll get when running `../scripts/busybox-container.sh`
(assuming this is your working directory) is laid out as follows:

- This directory is mapped to `/workspace`
- The `../dist` directory is mapped to `/dist` (guaranteed to be provided as
  `$DIST`)
- The `/src` directory (provided in the container as the `$SRC` environment
  variable) contains source trees for all the programs you will need to build

For this lab, you will be building code from the following source directories:

1. `/src/kernel` which contains the kernel source code and headers.
2. `/src/musl` for the musl libc
3. `/src/busybox` for the busybox utilities.

## Hints

1. Debian uses glibc. Our busybox is not allowed to use this c library. Make sure to
   compile+install the musl library (source code at `$SRC/musl`) and then set up
   your compile flags so that busybox looks there, not at the system libc.
2. Don't forget to use out of tree builds and the destination directory
   conventions as described in [Handout 2](https://junikimm717.github.io/fls-lectures/notes2.pdf).
   Compilation can take a long time so you want to ensure aggressive caching.
3. Certain busybox utilities may need to be disabled if compilation fails. This
   is expected.
4. Please use the stated environment variables over hard coding paths. The
   grader may intentionally test this by scrambling up paths but providing you
   with the correct `$SRC` and `$DIST` variables.

The following will indicate success:

```bash
# all of this is occurring inside your container.
# $ARCH is either aarch64 or x86_64 depending on your machine.
chroot /dist/busybox
# should error because the busybox binary is not dynamically linked.
/lib/ld-musl-$ARCH.so.1 --list /bin/busybox
# the binary should be functional though.
/bin/busybox ls
```
