FROM php:7.3-fpm-alpine
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN apk --no-cache update \
&& apk add --no-cache $PHPIZE_DEPS postgresql-dev libpng-dev libjpeg-turbo-dev icu-dev \
&& docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
&& docker-php-ext-configure intl --enable-intl \
&& docker-php-ext-install exif pdo_pgsql gd intl opcache pcntl
RUN pecl install xdebug \
&& docker-php-ext-enable xdebug

WORKDIR /var/www/html
