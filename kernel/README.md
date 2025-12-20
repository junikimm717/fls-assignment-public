# Building the Kernel

To start this lab, run `../docker/kernel-container.sh` to start the
corresponding environment for this lab.

You should aim to modify `./build.sh` such that in a clean run, it is capable of
compiling a linux kernel binary and placing it at `$DIST/linuximage`. You will have
other scripts later on that work with the `$DIST/linuximage` kernel binary.

Your script should also install kernel headers into `$ROOTFS/usr/include`

Furthermore, place all kernel headers into `$ROOTFS/usr/include` as they will be
required for compiling certain userspace programs later down the line.
