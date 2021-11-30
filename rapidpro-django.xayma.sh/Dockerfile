FROM supermalang/rapidpro-base:v4-slim-buster
ENV PIP_RETRIES=120 \
    PIP_TIMEOUT=400 \
    PIP_DEFAULT_TIMEOUT=400 \
    C_FORCE_ROOT=1 
    #PIP_EXTRA_INDEX_URL="https://alpine-3.wheelhouse.praekelt.org/simple"

# TODO determine if a more recent version of Node is needed
# TODO extract openssl and tar to their own upgrade/install line
RUN set -ex \
  && apt update && apt install -y --no-install-recommends nodejs npm openssl \
  && npm install -g coffee-script less bower

WORKDIR /rapidpro

RUN set -ex \
        && apt install -y --no-install-recommends \
            postgresql-client-11 \
            postgresql-server-dev-11 \
            readline-common \
            nginx

# Install `libmagic` (needed since rapidpro v3.0.64)
RUN apt-get install -y --no-install-recommends libmagic1

ARG RAPIDPRO_VERSION
ARG RAPIDPRO_REPO
ENV RAPIDPRO_VERSION=${RAPIDPRO_VERSION:-master}
ENV RAPIDPRO_REPO=${RAPIDPRO_REPO:-rapidpro/rapidpro}
RUN echo "Downloading RapidPro ${RAPIDPRO_VERSION} from https://github.com/$RAPIDPRO_REPO/archive/${RAPIDPRO_VERSION}.tar.gz" && \
    wget -O rapidpro.tar.gz "https://github.com/$RAPIDPRO_REPO/archive/${RAPIDPRO_VERSION}.tar.gz" && \
    tar -xf rapidpro.tar.gz --strip-components=1 && \
    rm rapidpro.tar.gz

# Install Rust, it's required to build poetry on this version of alpine
ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
        && pip3 install -U pip && pip3 install -U poetry \
        && rustup self uninstall -y

# Build Python virtualenv
RUN python3 -m venv /venv
ENV PATH="/venv/bin:${PATH}"
ENV VIRTUAL_ENV="/venv"

# Install configuration related dependencies
RUN /venv/bin/pip3 install --upgrade pip && /venv/bin/pip3 install -U pip wheel setuptools && poetry install --no-interaction --no-dev && poetry add \
        "django-cache-url==3.2.3" \
        "django-getenv==1.3.2" \
        "django-utils-six==2.0" \
        "flower==1.0.0" \
        "tornado<6.0.0" \
        "uwsgi==2.0.20" \
        "whitenoise==5.3.0" 

RUN cd /rapidpro \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install \
    && poetry install --no-interaction --no-dev


ENV UWSGI_VIRTUALENV=/venv UWSGI_WSGI_FILE=temba/wsgi.py UWSGI_HTTP=:8000 UWSGI_MASTER=1 UWSGI_WORKERS=8 UWSGI_HARAKIRI=20
# Enable HTTP 1.1 Keep Alive options for uWSGI (http-auto-chunked needed when ConditionalGetMiddleware not installed)
# These options don't appear to be configurable via environment variables, so pass them in here instead
ENV STARTUP_CMD="/venv/bin/uwsgi --http-auto-chunked --http-keepalive"

COPY settings.py /rapidpro/temba/
# 500.html needed to keep the missing template from causing an exception during error handling
COPY stack/500.html /rapidpro/templates/
COPY stack/init_db.sql /rapidpro/
COPY stack/clear-compressor-cache.py /rapidpro/

EXPOSE 8000
COPY stack/startup.sh /

LABEL org.label-schema.name="RapidPro" \
      org.label-schema.description="RapidPro allows organizations to visually build scalable interactive messaging applications." \
      org.label-schema.url="https://www.rapidpro.io/" \
      org.label-schema.vcs-url="https://github.com/$RAPIDPRO_REPO" \
      org.label-schema.vendor="VisiMax by Supermalang" \
      org.label-schema.version=$RAPIDPRO_VERSION \
      org.label-schema.schema-version="1.0"

CMD ["/startup.sh"]