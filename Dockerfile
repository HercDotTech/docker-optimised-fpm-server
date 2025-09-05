# Initialize container image
FROM php:8.4-fpm-alpine
LABEL maintainer="<HercDotTech> office@herc.tech"

# Install OPCache
RUN docker-php-ext-install opcache

# Install APCu
RUN apk add --update --no-cache --virtual .build-dependencies $PHPIZE_DEPS && \
    pecl install apcu && \
    docker-php-ext-enable apcu && \
    pecl clear-cache && \
    apk del .build-dependencies

# Install xDebug
RUN apk add --no-cache $PHPIZE_DEPS linux-headers && \
    pecl install xdebug && docker-php-ext-enable xdebug