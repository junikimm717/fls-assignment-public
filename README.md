# 6.S913 Assignment

Receiving credit for this class involves ensuring that you are able to create a
bootable disk image with a login screen.

# Structure

There are three main directories to consider:

1. busybox - corresponding to the first lab where students will be responsible
   for compiling a statically linked busybox binary and create an initramfs
   image from that.
2. kernel - corresponding to the second lab where students will be building up a
   kernel binary and then running that alongside an initramfs.
3. user - corresponding to the third lab where students are expected to put it
   all together.

In the final system, the following order is expected:
1. the busybox part of the lab is built up.
2. the kernel part of the lab is built up.
3. The contents of `./dist/busybox` and `./dist/kernel` are rsync'd into
   `./dist/user`
4. the user part of the lab is built up.
