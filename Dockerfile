FROM php:7.2-fpm-alpine

RUN apk update && apk add --no-cache \
    bash \
    build-base \
    curl \
    imap-dev \
    php7 \
    php7-common \
    php7-dom \
    php7-fpm \
    php7-gd \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqli \
    php7-imap \
    php7-json \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-pcntl \
    php7-session \
    php7-xml \
    php7-zip \
    php7-zlib \
    shadow \
    vim

RUN docker-php-ext-install imap pcntl pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data

RUN chown -R www-data:www-data /var/www

USER www-data

EXPOSE 9000
CMD ["php-fpm"]