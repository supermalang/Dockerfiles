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
    && git clone --depth 1 --branch "v$MAILROOM_VERSION" "https://github.com/$MAILROOM_REPO.git" \
    && cd mailroom \
    && go build "github.com/$MAILROOM_REPO"/cmd/mailroom  \
    && cp mailroom /go/bin \ 
    && apt-get purge -y --auto-remove 

EXPOSE 8090

USER mailroom

ENTRYPOINT []
CMD ["mailroom"]
