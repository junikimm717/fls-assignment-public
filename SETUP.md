# Dependencies

This course requires a Linux environment with [Docker](https://docker.com) installed.
All project build processes will occur on a docker container, so few other
dependencies are strictly required.

## Linux

Install `docker` (`docker.io` on Debian or Ubuntu-based distributions) via your
native package manager. Your user should be part of the `docker` group to access
the docker socket.

## MacOS

Use the [Homebrew](https://brew.sh) package manager to install
[Colima](https://github.com/abiosoft/colima) or
[Orbstack](https://orbstack.dev/) (the free version is fine).

We do not recommend
[Docker Desktop](https://www.docker.com/products/docker-desktop/)
due to performance reasons.

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

1. Install Windows Subsystem for Linux (wsl) 2, then reboot
2. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/),
   and enable "Use WSL 2 instead of Hyper-V" **during installation** (this
   option is probably enabled by default), then reboot.
3. In Docker Desktop, go to `Settings -> Resources -> WSL Integration`, and
   enable the integration for **Ubuntu**.

Installing wsl involves running the following on powershell:
```bash
wsl --install
```
