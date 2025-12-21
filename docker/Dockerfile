FROM debian:trixie
RUN apt-get update
RUN apt-get install -y gcc make autoconf automake cmake\
  e2fsprogs cpio rsync curl xz-utils mtools dosfstools gdisk\
  bzip2 flex bison bc libssl-dev libncurses-dev\
  vim file

# install all source tarballs at the same time.
RUN mkdir src && cd src \
  && curl -LJO https://dev.mit.junic.kim/fls.tar.gz \
  && tar xzvf fls.tar.gz \
  && rm -rf fls.tar.gz

WORKDIR /workspace
COPY ./devshell.sh /devshell.sh

# this is to make sure the container doesn't just exit.
ENTRYPOINT ["/bin/sh", "-c", "trap 'exit 0' SIGTERM; while :; do sleep 1; done"]
