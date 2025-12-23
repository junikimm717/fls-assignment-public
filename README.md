# 6.S913 Assignment

The only assignment of the course; to create a build system generating a
functional linux-based operating system.

See the syllabus [here](./syllabus.md).

# Setup

This course requires a Linux environment with [Docker](https://docker.com) installed.
All project build processes will occur on a docker container, so few other
dependencies are strictly required.

If you are on MacOS, you should use the [Homebrew](https://brew.sh) package
manager to install either [Orbstack](https://orbstack.dev/) (the free version is
fine) or [Docker Desktop](https://www.docker.com/products/docker-desktop/).

### Windows

If you are on Windows, you need to

1. install Windows Subsystem for Linux (wsl) 2
2. install [Docker Desktop](https://www.docker.com/products/docker-desktop/),
   and enable "Use WSL 2 instead of Hyper-V"
3. in Docker Desktop, go to `Settings -> Resources -> WSL Integration`, and
   enable the integration for **Ubuntu**.

# Architecture

In this class, you will be implementing an OS building pipeline based around
**native** build targets. Cross compilation is cool but a completely different
beast and not supported.

Run the following command on your system (WSL on Windows):

```bash
docker run alpine arch
```

If that outputs `aarch64` (M-series Macs), you are targeting aarch64. If it
outputs `x86_64` (most other computers), you are targeting x86. Other
architectures will not be supported by this class.

# Structure

There are several main directories to consider, which should be completed
roughly in the order described:

1. `busybox/` - students will be compiling up busybox and musl, installing that
   onto a filesystem image, and generating an initramfs image.
2. `kernel/` - students will configure and build a linux kernel.
3. `user/` - students will populate the rest of the root filesystem with
   essential system configuration files and daemon programs.
4. `image/` - students will automate bootable disk image generation.

In the final system, the following process is expected to succeed:

1. the busybox part of the lab is built up.
2. the kernel part of the lab is built up.
3. the user part of the lab is built up, creating the root filesystem.
4. The image part of the lab runs, building up the final bootable image.

For reference, this is roughly the container script that we will be running to
build up your image:

```bash
cd /workspace
ROOTFS="/dist/busybox" ./busybox/build.sh
ROOTFS="/dist/kernel" ./kernel/build.sh
ROOTFS="/dist/user" ./user/build.sh
ROOTFS="/dist/image" ./image/build.sh
```
