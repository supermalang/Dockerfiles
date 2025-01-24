ARG WP_VERSION

# Use the Bitnami WordPress image as the base
FROM bitnami/wordpress:${WP_VERSION}

# Ensure the directory exists and update the package list
USER root

RUN mkdir -p /var/lib/apt/lists/partial apt-get clean

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    php-pear \
    php-dev \
    autoconf \
    gcc \
    make \
    libtool \
    pkg-config 

# Install phpredis
RUN pecl install --onlyreqdeps --force redis \
    && echo "extension=redis.so" > /opt/bitnami/php/etc/conf.d/20-redis.ini \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /bitnami/wordpress

EXPOSE 8080 8443
USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/wordpress/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/apache/run.sh" ]