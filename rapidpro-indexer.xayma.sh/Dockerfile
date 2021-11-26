FROM golang:1.17-buster

RUN set -ex; \
    addgroup --system rp_indexer; \
    adduser --system --ingroup rp_indexer rp_indexer

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ARG RP_INDEXER_REPO=nyaruka/rp-indexer
ENV RP_INDEXER_REPO=${RP_INDEXER_REPO}
ARG RP_INDEXER_VERSION=7.0.0
ENV RP_INDEXER_VERSION=${RP_INDEXER_VERSION}

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --depth 1 "https://github.com/$RP_INDEXER_REPO.git" \
    && cd rp-indexer \
    && go build "github.com/$RP_INDEXER_REPO"/cmd/rp-indexer  \
    && cp rp-indexer /go/bin \ 
    && apt-get purge -y --auto-remove 

EXPOSE 8080

USER rp_indexer

ENTRYPOINT []
CMD ["rp-indexer"]

