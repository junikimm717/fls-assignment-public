# Infra Scripts for 6.S913

If you are a student working on a lab, please do not edit any of the scripts
here (that is for your own benefit). These scripts are responsible for setting
up the docker infrastructure for you to do your labs.

## Student Docker Environments

The following scripts, when invoked, will drop students into a docker
environment for them to test each individual stage of their build process.

1. busybox-container.sh - building up the initramfs and busybox/musl
2. kernel-container.sh - building up a kernel binary
3. user-container.sh - building up a properly configured rootfs
4. image-container.sh - stitching the image together

## Container Persistence

Although each part of the assignment uses a different container, those
containers will be kept alive as long as possible, and all containers are based
off the same docker image (see the `Dockerfile`).

If a student runs say `./busybox-container.sh` twice in two different windows,
you now have two shells into the same container. If you want to restart the
environment, you need to kill the container.

```bash
# view all active containers
docker ps
docker kill busybox-builder-lfs
```

## Grading

The graders will run the `test-container.sh` script to test students' build
pipelines. In the end, a bootable image should exist at `dist/bootable.img`.

This bootable image can then be graded with `grade-image.sh`.
