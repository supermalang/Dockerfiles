FROM php:7.4-apache
COPY ./my-httpd.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        zlib1g-dev \
        libzip-dev \
        libxml2-dev \
        libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install zip mysqli pdo pdo_mysql intl

RUN mv ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini \
    && sed -E -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 128M/' ${PHP_INI_DIR}/php.ini \
    && sed -E -i -e 's/post_max_size = 8M/post_max_size = 128M/' ${PHP_INI_DIR}/php.ini \
    && sed -E -i -e 's/memory_limit = 128M/memory_limit = 256M/' ${PHP_INI_DIR}/php.ini

WORKDIR /var/www

ARG XAYMA_APP_VERSION=0.9.41
ENV XAYMA_APP_VERSION=${XAYMA_APP_VERSION}

RUN git clone --depth 1 https://github.com/supermalang/app.xayma.sh.git \
    && curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && cd app.xayma.sh \
    && /usr/local/bin/composer install \
    && chown -R www-data:www-data /var/www/app.xayma.sh \
    && php /var/www/app.xayma.sh/bin/console cache:clear
    

CMD ["apachectl", "-D", "FOREGROUND"]

EXPOSE 80
