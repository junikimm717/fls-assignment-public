# Building User Programs and the Root Filesystem

To start this lab, `cd` to this directory and run
`../scripts/user-container.sh` to get a shell into the docker container for
this lab.

The **build.sh** script will be run by the graders to check whether you
correctly configure the root filesystem.

Please feel free to write **additional scripts** to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.

## Container Layout

The container that you'll get when running `../scripts/user-container.sh`
(assuming this is your working directory) is laid out as follows:

- This directory is mapped to `/workspace`
- The `../dist` directory is mapped to `/dist` (which is also equal to the value
  of the `$DIST` environment variable)
- The `/src` directory (provided in the container as the `$SRC` environment
  variable) contains source trees for all the programs you will need to build

## Required

1. A properly configured busybox init file at `/etc/inittab` and a startup
   script `/etc/init.d/rcS` (this needs to be wired up to `/etc/inittab`)
2. `/etc/inittab` must be configured so that busybox init mounts essential
   kernel filesystems and starts essential daemons, most importantly getty and
   eudev.
3. Properly configured `/etc/group`, `/etc/shadow`, `/etc/passwd` (so that the
   root user can actually log in)
4. A hostname set to your kerb.
5. dhcpcd, eudev, and chrony running on your system.

## Optional

1. Regular users and doas (must be set as a SUID binary when constructing the
   bootable image)
