FROM php:8.1.10-cli as build-stage

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libonig-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libicu-dev \
    libzip-dev \
    patch \
    pkg-config \
    nano \
    gdb \
    && rm -rf /var/cache/apt/*

RUN mkdir -p /usr/src \
    && cd /usr/src \
    && curl -fsSL -o php.tar.xz "$PHP_URL" \
    && docker-php-source extract \
    && cd /usr/src/php \
    && ./configure \
        --enable-debug \
        --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
        --with-config-file-path="$PHP_INI_DIR" \
        --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
        --enable-option-checking=fatal \
        --with-sqlite3=/usr \
        --with-openssl \
        --with-readline \
        --with-zlib \
        --disable-phpdbg \
        --without-pear \
        --with-libdir="lib/$(dpkg-architecture --query DEB_BUILD_MULTIARCH)" \
        --disable-cgi \
        --disable-fpm \
        --enable-bcmath \
        --disable-calendar \
        --with-curl \
        --disable-exif \
        --without-ffi \
        --disable-ftp \
        --with-gettext \
        --without-gmp \
        --with-mhash \
        --with-iconv \
        --enable-intl \
        --enable-mbstring \
        --enable-mysqlnd \
        --with-mysqli \
        --enable-opcache \
        --enable-pcntl \
        --enable-pdo \
        --with-pdo-mysql \
        --enable-shmop \
        --enable-sockets \
        --without-sodium \
        --without-password-argon2 \
        --with-zip \
    && make -j "$(nproc)" \
    && make install \
    && rm -rf rm /usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

RUN echo "\
zend_extension=opcache.so\n\
memory_limit = 256M\n\
opcache.enable = 1\n\
opcache.enable_cli = 1\n\
opcache.memory_consumption = 48\n\
opcache.max_accelerated_files = 50000\n\
opcache.jit_buffer_size = 48M\n\
" > /usr/local/etc/php/conf.d/config.ini

WORKDIR /var/www
