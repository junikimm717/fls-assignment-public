# Building User Programs and the Root Filesystem

To start this lab, run `../docker/user-container.sh` to start the corresponding
environment for this section of the lab.

The **build.sh** script will be run by the graders to check whether you
correctly configure the root filesystem.

Please feel free to write **additional scripts** to automate any other tasks
(clearing build artifacts, running qemu, etc.) that you would like automated.

Things that you must have:

1. A properly configured /sbin/init
2. The init must set up essential kernel filesystems
3. getty running on a terminal (so you can log in to a shell)

Optional things:

1. Eudev (for device management)
2. Chrony (as an ntp client)
3. SUID binaries (such as doas)
