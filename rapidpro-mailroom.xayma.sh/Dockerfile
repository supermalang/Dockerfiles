FROM debian:buster-slim

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
    && wget "https://github.com/$MAILROOM_REPO/releases/download/v${MAILROOM_VERSION}/mailroom_${MAILROOM_VERSION}_linux_amd64.tar.gz" \
    && mv "mailroom_${MAILROOM_VERSION}_linux_amd64.tar.gz" mailroom.tar.gz \
    && mkdir /home/mailroom/mailroom_release \
    && tar -xzf mailroom.tar.gz -C /home/mailroom/mailroom_release/ \
    \
    && apt-get purge -y --auto-remove

EXPOSE 8090

USER mailroom


ENTRYPOINT []
CMD cd /home/mailroom/mailroom_release/ && ./mailroom

