# 6.S913 Assignment

The only assignment of the course; to create a build system generating a
functional Linux-based operating system.

See the syllabus [here](./syllabus.md).

If you do not have docker installed on your system (it is effectively the only
real dependency) please consult [SETUP.md](./SETUP.md).

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

1. `busybox/` - students will be writing a script that compiles up Busybox and
   musl, installing the required files onto a target filesystem, and generating
   an initramfs image.
2. `kernel/` - students will write a script that configures and builds a Linux
   kernel.
3. `user/` - students will populate the rest of the root filesystem with
   essential system configuration files and daemon programs.
4. `image/` - students will automate bootable disk image generation.

For further information about each part of the lab, please consult the README
under each subdirectory. For security reasons, your build scripts will not be
provided with a connection to the open internet; the required source code is
provided in the docker image.

The `scripts/` directory contains all the infrastructure scripts for the
assignment. It can launch docker containers per assignment.

# Final Result

You must design a build pipeline that builds up a functional Linux system.

For both building and grading, your pipeline will **not** be given an open
internet connection. For building, you should assume all directories outside of
`$DIST` will be locked down to be read-only.

Students registered for the class will be submitting on the class portal at
[6s913.mit.junic.kim](https://6s913.mit.junic.kim).

Please try to submit to the autograder only once you have confirmed that your
pipeline works correctly as explained by the instructions below. We have limited
infrastructure, so please be conservative with submissions.

## Building

The scripts described in the previous sections should result in a pipeline that
builds up a bootable image at `./dist/bootable.img`. We will be running the
following programs in sequence with the following time limits:

1. `./busybox/build.sh` with 5 minutes
2. `./kernel/build.sh` with 20 minutes
3. `./user/build.sh` with 5 minutes
4. `./image/build.sh` with 5 minutes

Grading will occur on AWS instances with 8GB RAM and 4 vCPU's.

To test the pipeline we will run, run the `./scripts/test-container.sh` script.
If the build process succeeds, it should output a bootable image at
`./dist/bootable.img` (the file name must be exact).

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

## Submitting

**Important Note**: Please ensure your repository is devoid of symlinks or any
non-regular files. For security reasons, the grader will automatically reject
submissions that contain such files.

1. Log into the portal at [6s913.mit.junic.kim](https://6s913.mit.junic.kim)
2. Run `./scripts/prepare-submission.sh`. That will output a tar.gz file in
   `dist/`
3. Submit the tar.gz file at [6s913.mit.junic.kim/portal/submit](https://6s913.mit.junic.kim/portal/submit)
4. Wait for the grader to output your submission result. If you click on the
   submission number, you will be redirected to a page where you can browse the
   build logs and download your original tarball.

The build log is truncated at 20MB to prevent certain classes of DoS attacks.
