FROM ubuntu:22.04

LABEL maintainer="Xijia Che"
LABEL Description="Image for building and testing CVE-2016-8704"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libevent-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/end-to-end-poc
ADD . /usr/end-to-end-poc

# install dependencies
RUN buildDeps=' \
    gcc \
    libc6-dev \
    libevent-dev \
    make \
    perl \
    wget \
    libncurses5-dev \
    libncursesw5-dev \
    ' \
    && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN bash scripts/build_memcached.sh
RUN bash scripts/build_openssl.sh
RUN bash scripts/build_redis.sh
RUN bash scripts/build_vim.sh
RUN bash scripts/build_libevent.sh

EXPOSE 11211
CMD ["bash"]