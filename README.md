# 6.S913 Assignment

The only assignment of the course; to create a build system generating a
functional linux-based operating system.

See the syllabus [here](./syllabus.md).

# Structure

There are several main directories to consider, which should be completed
roughly in the order described:

1. busybox - students will be compiling up busybox and musl, installing that
   onto a filesystem image, and generating an initramfs image.
2. kernel - students will configure and build a linux kernel.
3. user - students will populate the rest of the root filesystem with daemons.
4. image -  students will automate bootable disk image generation.

In the final system, the following process is expected to succeed:

1. the busybox part of the lab is built up.
2. the kernel part of the lab is built up.
3. The contents of `./dist/busybox` and `./dist/kernel` are rsync'd into
   `./dist/user`, followed by the population of the rest of the root filesystem
   (the `user` part).
5. The image part of the lab runs, building up the final bootable image.
