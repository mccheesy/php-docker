FROM php:7.4-fpm-alpine

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="mccheesy/php7.4-fpm" \
    org.label-schema.description="PHP-FPM built on Alpine Linux with a sane set of extensions for modern app development." \
    maintainer="jmccleese@gmail.com"

RUN apk update && apk add --no-cache \
    icu-dev \
    imap-dev \
    libpng-dev \
    libzip-dev \
    shadow \
    zlib-dev

RUN docker-php-ext-install \
    bcmath \
    gd \
    imap \
    intl \
    pcntl \
    pdo_mysql \
    zip 

RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data

RUN chown -R www-data:www-data /var/www

USER www-data

EXPOSE 9000
CMD ["php-fpm"]
