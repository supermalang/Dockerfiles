FROM golang:1.17-buster

RUN set -ex; \
    addgroup --system mailroom; \
    adduser --system --ingroup mailroom mailroom

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ARG MAILROOM_REPO=nyaruka/mailroom
ENV MAILROOM_REPO=${MAILROOM_REPO}
ARG MAILROOM_VERSION=7.0.1
ENV MAILROOM_VERSION=${MAILROOM_VERSION}

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && rm -rf /var/lib/apt/lists/* \
    wget -O mailroom.tar.gz "https://github.com/$MAILROOM_REPO/releases/download/v${MAILROOM_VERSION}/mailroom_${MAILROOM_VERSION}_linux_amd64.tar.gz"; \
    mkdir /usr/local/src/mailroom; \
    tar -xzC /usr/local/src/mailroom -f mailroom.tar.gz; \
    \
    # Just grab the binary and the docs directory
    mv /usr/local/src/mailroom/mailroom /usr/local/bin/; \
    mv /usr/local/src/mailroom/docs /; \
    rm -rf /usr/local/src/mailroom mailroom.tar.gz; \
    \
    apt-get purge -y --auto-remove 

EXPOSE 8090

USER mailroom

ENTRYPOINT []
CMD ["mailroom"]
