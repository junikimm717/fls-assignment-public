---
title: 6.S913 Fundamentals of Linux Systems Syllabus
author: Juni Kim (junickim)
date: 12/20/2025
geometry: margin=1in
---

This class is intended as a crash course for students to understand the basics
of how modern linux systems operate and how they themselves may be able to
construct one.

# Assignments

The assignment for this course has four main parts, named `busybox`, `kernel`,
`image`, `user`, which represent different stages of an OS bootstrapping build
system. All parts must be completed and integrated together to receive credit
for the course. The parts all rely on one another. The assignment must be
submitted by **Friday, January 30, 2026 at 11:59PM**.

Students will be given a somewhat minimal scaffold for their projects and will
be responsible for submitting a tarball for their project. More instructions are
in the assignment repository README.

Labs should be done on sufficiently modern hardware (for reference, you should
expect to compile the linux kernel). Docker is required on all systems, and
Windows users are strongly advised to use wsl.

There will be multiple lab hours designed to help students with the checkpoints.

# Schedule

## Lecture 1 - Tuesday 1/20 1-3PM, 34-301

- Course structure
- A review over shell scripting fundamentals including environment variables,
  program invocation, and path resolution.
- Principles behind build scripts: Filesystem hygiene, working directory invariance,
  idempotency, environment variable manipulation.
- How does one use docker? Why is it so important?

## Lecture 2 - Wednesday 1/21 1-3PM, 34-301

- Understanding the build process
  (`./configure`, `make -jn`, `make install DESTDIR=...`)
  and all the tools that make that possible.
- What are the different compile flags? Why does the libc matter so much?
- How does one use QEMU (the virtualization software used in the course) and
  what are the most important options?
- (related to above) why do you need the kernel and initramfs archive?

**live demo**: show a booting kernel alongside an initramfs.

## Lab 1 - Wednesday 1/21 End of Lecture-5PM, TBD

Help will be available for all parts of the lab, but we will prioritize those
with questions about lab setup and the `busybox` section.

## Lecture 3 - Friday 1/23 1-3PM, 34-301

- Continuing Lecture 2: Reminder on keeping build paths organized
- Manual kernel configuration (modules, drivers, ...), show how `make menuconfig` works
- What is the kernel command line? Why is it so important
- Real and Pseudo filesystems
  - Demo of why we need /proc, /dev, /sys, /tmp ...
- What does init actually do? Why did systemd become a thing?

## Lab 2 - Friday 1/23 End of Lecture-5PM, TBD

Help will be available for all parts of the lab, but we will prioritize those
with questions regarding the `kernel` and `image` section.

By this point, students should have a compiled and working kernel binary and the
ability to boot up a kernel into an initramfs.

## Lecture 4 - Monday 1/26 1-3PM, 34-301

- Mounting userland filesystems, determining user permissions
- How init schemes work (demonstration with busybox's init)
- Students should know how a bootable image file works, including how partition
  tables, filesystems, and firmware interact.
  - What are all the filesystem tools that get used
  - How does the hardware know what to boot (special case of EFI firmware), and
    why can we just let the kernel take care of it?
- Important daemons (getty, eudev, chrony, dhcpcd) and why you need them

## Lab 3 - Tuesday 1/26 1-5PM, TBD

Help will focus on the `image` and `user` sections of the lab.

## Lecture 5 - Thursday 1/29 1-3PM, 34-301

- SUID binaries (doas)
- Configuring users and groups
- Some other advanced topics
  - Certificate authorities for https requests (openssl)
  - Timezone data
- Course Wrapup

## Lab 4 - Thursday 1/29 End of Lecture-5PM, TBD

Help will focus on the `image` and `user` sections of the lab.

## Assignment DUE - Friday 1/30 EOD
