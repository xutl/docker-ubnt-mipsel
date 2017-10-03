FROM ubuntu:16.04

MAINTAINER XUTONGLE <xutongle@gmail.com>

WORKDIR /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
    g++-mipsel-linux-gnu gcc-mipsel-linux-gnu \
    gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto \
    libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev \
    wget git ca-certificates openssl

## libsodium
RUN wget --no-check-certificate https://download.libsodium.org/libsodium/releases/libsodium-1.0.15.tar.gz && \
    tar zxf libsodium-1.0.15.tar.gz && cd libsodium-1.0.15 && \
    ./configure --host=mipsel-linux-gnu --prefix=/opt/libsodium --disable-ssp --disable-shared && \
    make && make install && \
    cd /tmp/ && \

## pcre
    wget -c --no-check-certificate https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz && \
    tar xzf pcre-8.41.tar.gz && cd pcre-8.41 && \
    ./configure --prefix=/opt/pcre --host=mipsel-linux-gnu --disable-shared --enable-utf --enable-unicode-properties && \
    make && make install && \
    cd /tmp/ && \

# mbedtls
    wget --no-check-certificate https://tls.mbed.org/download/mbedtls-2.6.0-gpl.tgz \
    && tar zxf mbedtls-2.6.0-gpl.tgz \
    && cd mbedtls-2.6.0 \
    && sed -i "s/DESTDIR=\/usr\/local/DESTDIR=\/opt\/mbedtls/g" Makefile \
    && CC=mipsel-linux-gnu-gcc AR=mipsel-linux-gnu-ar LD=mipsel-linux-gnu-ld LDFLAGS=-static make install && \
    cd /tmp/ && \

# shadowsocks
    git clone https://github.com/shadowsocks/shadowsocks-libev && \
    cd shadowsocks-libev && git submodule init && git submodule update && \
    cd /tmp/