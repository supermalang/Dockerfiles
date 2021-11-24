FROM python:3.9-slim-buster

COPY stack/geolibs.sh /
RUN set -ex \
        && apt-get update && apt-get install -y --no-install-recommends \
            bash \
            bzip2 \
            cargo \
            curl \
            g++ \
            gcc \
            git \
            libc-dev \
            libffi-dev \
            libfreetype6-dev \
            libgdal-dev \
            libgdal20 \
            libjpeg62-turbo-dev \
            libncurses-dev \
            libpcre3-dev \
            libpng-dev \
            libpq-dev \
            libreadline-dev \
            libsqlite3-dev \
            libtiff5-dev \
            libxml2-dev \
            libxslt-dev \
            libzmq5 \
            linux-headers-amd64 \
            make \
            musl-dev \
            patch \
            pkg-config \
            python3-dev \
            python3-gdal \
            sqlite3 \
            wget \
            zlib1g-dev \
        && sh /geolibs.sh 

CMD ["python3"]
