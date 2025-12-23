# Building the Kernel

To start this lab, run `../docker/kernel-container.sh` to start the
corresponding environment for this lab.

You should aim to modify `./build.sh` such that in a clean run, it is capable of
compiling a Linux kernel binary and placing it at `$DIST/linuximage`. You will
have other scripts later on that work with the `$DIST/linuximage` kernel binary.

Please feel free to write **additional scripts** to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.

## Re-Compiling

Depending on your system, the kernel might take a very long time to run. It is
advised that all build artifacts are emitted to an isolated subdirectory of
`$DIST` so it's persistent across container restarts.

You should probably use the `-j` option in `make` for parallelization. The
grading machine will use a substantial number of cores to accelerate builds,
and we will not tolerate excessively long build times.

## Container Layout

The container that you'll get when running `../docker/kernel-container.sh`
(assuming this is your working directory) is laid out as follows:

- This directory is mapped to `/workspace`
- The `../dist` directory is mapped to `/dist` (which is also equal to the value
  of the `$DIST` environment variable)
- The `/src` directory (provided in the container as the `$SRC` environment
  variable) contains source trees for all the programs you will need to build

## Requirements

1. The kernel should include your initramfs image (which you probably built up
   at `/dist/archive.cpio.gz`), you should configure this in
   `CONFIG_INITRAMFS_SOURCE`
2. The kernel should be a single binary without modules, and also be capable of
   acting as an EFI stub.
