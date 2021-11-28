FROM golang:1.17-buster

RUN set -ex; \
    addgroup --system rp_archiver; \
    adduser --system --ingroup rp_archiver rp_archiver

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ARG RP_ARCHIVER_REPO=nyaruka/rp-archiver
ENV RP_ARCHIVER_REPO=${RP_ARCHIVER_REPO}
ARG RP_ARCHIVER_VERSION=7.0.0
ENV RP_ARCHIVER_VERSION=${RP_ARCHIVER_VERSION}

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --depth 1 --branch "v$RP_ARCHIVER_VERSION" "https://github.com/$RP_ARCHIVER_REPO.git" \
    && cd rp-archiver \
    && go build "github.com/$RP_ARCHIVER_REPO"/cmd/rp-archiver  \
    && cp rp-archiver /go/bin \ 
    && apt-get purge -y --auto-remove 

EXPOSE 8080

USER rp_archiver

ENTRYPOINT []
CMD ["rp-archiver"]

