# Building User Programs and the Root Filesystem

To start this lab, run `../docker/user-container.sh` to start the corresponding
environment for this section of the lab.

The **build.sh** script will be run by the graders to check whether you
correctly configure the root filesystem.

Please feel free to write **additional scripts** to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.

## Container Layout

The container that you'll get when running `../docker/user-container.sh`
(assuming this is your working directory) is laid out as follows:

- This directory is mapped to `/workspace`
- The `../dist` directory is mapped to `/dist` (which is also equal to the value
  of the `$DIST` environment variable)
- The `/src` directory (provided in the container as the `$SRC` environment
  variable) contains source trees for all the programs you will need to build

## Required

1. A properly configured busybox init file at `/etc/inittab` and a startup
   script `/etc/init.d/rcS` (this needs to be wired up to `/etc/inittab`)
2. The init must set up essential kernel filesystems and spin up essential
   daemons, most importantly getty and eudev.
3. Properly configured `/etc/group`, `/etc/shadow`, `/etc/passwd` (so that the
   root user can actually log in)

## Optional

1. Dhcpcd (for internet connectivity)
2. Chrony (ntp client)
3. Regular users and doas (must be set as a SUID binary when constructing the
   bootable image)
