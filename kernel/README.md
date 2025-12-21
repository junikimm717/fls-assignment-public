# Building the Kernel

To start this lab, run `../docker/kernel-container.sh` to start the
corresponding environment for this lab.

You should aim to modify `./build.sh` such that in a clean run, it is capable of
compiling a linux kernel binary and placing it at `$DIST/linuximage`. You will
have other scripts later on that work with the `$DIST/linuximage` kernel binary.

Please feel free to write **additional scripts** to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.
