# Busybox

To get started on this lab, run `../docker/busybox-container.sh` which will drop
you into a dev shell.

It is recommended to use the variable `$ROOTFS` instead of `/dist/busybox` when
describing your installation paths for the build script. The directory
`$SRC/busybox` contains the copy of the busybox source code that you should use.

You also need to make sure you generate a proper initramfs cpio image at
`$DIST/archive.cpio.gz`.

Please feel free to write **additional scripts** to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.

Some hints:

1. Debian uses glibc. Our busybox may not use this c library. Make sure to
   compile+install the musl library (source code at `$SRC/musl`) and then set up
   your compile flags so that busybox looks there, not at the system libc.
2. Don't forget `DESTDIR`!

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
