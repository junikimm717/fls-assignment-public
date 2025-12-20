# Building User Programs and the Root Filesystem

To start this lab, run `../docker/user-container.sh` to start the corresponding
environment for this section of the lab.

Things that you must have:

1. A properly configured /sbin/init
2. The init must set up essential kernel filesystems
3. getty running on a terminal (so you can log in to a shell)

Optional things:

1. Eudev (for device management)
2. Chrony (as an ntp client)
3. SUID binaries (such as doas)
