FROM ubuntu:16.04

MAINTAINER XUTONGLE <xutongle@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    g++-mipsel-linux-gnu gcc-mipsel-linux-gnu \
    gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto \
    libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev \
    wget git ca-certificates openssl
