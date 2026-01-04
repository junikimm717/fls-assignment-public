# 6.S913 Assignment

The only assignment of the course; to create a build system generating a
functional Linux-based operating system.

See the syllabus [here](./syllabus.md).

# Setup

This course requires a Linux environment with [Docker](https://docker.com) installed.
All project build processes will occur on a docker container, so few other
dependencies are strictly required.

## Linux

Install `docker` (`docker.io` on Debian or Ubuntu-based distributions) via your
native package manager. Your user should be part of the `docker` group to access
the docker socket.

## MacOS

Use the [Homebrew](https://brew.sh) package manager to install either
[Orbstack](https://orbstack.dev/) (the free version is fine) or [Docker
Desktop](https://www.docker.com/products/docker-desktop/).

Please note that you may need to modify the `$PATH` variable in your `~/.zshrc`
for Homebrew to work correctly. In particular, you probably want the following
lines in your zshrc:

```bash
# The below prefix is /opt/homebrew for m-series macs, /usr/local for intel macs.
export PATH="\
:/opt/homebrew/bin\
:$HOME/.local/bin\
:$PATH"
```

## Windows

If you are on Windows, you need to

1. Install Windows Subsystem for Linux (wsl) 2
2. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/),
   and enable "Use WSL 2 instead of Hyper-V" **during installation**
3. In Docker Desktop, go to `Settings -> Resources -> WSL Integration`, and
   enable the integration for **Ubuntu**.

# Native Architecture

In this class, students will be implementing an OS bootstrapping pipeline based
on **native** build targets. Cross compilation is cool but a completely
different beast and not supported. If you want to attempt cross compilation, you
are welcome to do so, but it will not be graded.

Run the following command on your system (WSL if on Windows):

```bash
docker run alpine arch
```

If that outputs `aarch64` (M-series Macs), you are targeting aarch64. If it
outputs `x86_64` (most other computers), you are targeting x86. Other
architectures will not be supported by this class.

# Structure

There are several main subdirectories to consider, which should be completed
in the order described:

1. `busybox/` - students will be compiling up Busybox and musl, installing that
   onto a filesystem image, and generating an initramfs image.
2. `kernel/` - students will configure and build a Linux kernel.
3. `user/` - students will populate the rest of the root filesystem with
   essential system configuration files and daemon programs.
4. `image/` - students will automate bootable disk image generation.

For further information about each part of the lab, please consult the README
under each subdirectory. Your scripts must work **without** an internet
connection and will be graded in such an environment.

The `scripts/` directory contains all the infrastructure scripts for the
assignment.

# Final Result

You must design a build pipeline that builds up a functional Linux system.

For both building and grading, your pipeline will **not** be given an open
internet connection. For building, you should assume all directories outside of
`$DIST` will be locked down to be read-only.

## Building

The scripts described in the previous sections should result in a pipeline that
builds up a bootable image at `./dist/bootable.img`. The following is roughly
the container script that we will be running to build up your image (note the
sequence of execution):

```bash
ROOTFS="$DIST/busybox" ./busybox/build.sh
ROOTFS="$DIST/kernel" ./kernel/build.sh
ROOTFS="$DIST/user" ./user/build.sh
ROOTFS="$DIST/image" ./image/build.sh
```

To test the pipeline we will run, run the `./scripts/test-container.sh` script.

## Grading

Once you have your image at `./dist/bootable.img`, you can see whether it passes
the autograder by running `./scripts/grade-image.sh`. We will be checking for
the following:

1. The VM boots with kernel logs visible
2. A user can log into the VM as root with no password (important!)
3. Eudev, chrony, and dhcpcd are all running as daemons
4. The VM has a working network stack (we will ping a local server)
5. The VM keeps track of time correctly.
6. The VM can persist data on the disk across reboots

**Note:** This assignment evaluates honest system construction. Deliberate
attempts to deceive the grader or abuse the grading environment are considered
violations of academic integrity and may result in manual review and grade
adjustment.
