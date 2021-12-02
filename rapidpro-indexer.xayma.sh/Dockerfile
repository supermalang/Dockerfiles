FROM debian:buster-slim

RUN set -ex \
    && addgroup --system rp_indexer \
    && adduser --system --ingroup rp_indexer rp_indexer

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget && \
    rm -rf /var/lib/apt/lists/*

ARG RP_INDEXER_REPO=nyaruka/rp-indexer
ENV RP_INDEXER_REPO=${RP_INDEXER_REPO}
ARG RP_INDEXER_VERSION=7.0.0
ENV RP_INDEXER_VERSION=${RP_INDEXER_VERSION}



RUN set -ex \
    && wget -O rp-indexer.tar.gz "https://github.com/$RP_INDEXER_REPO/releases/download/v${RP_INDEXER_VERSION}/rp-indexer_${RP_INDEXER_VERSION}_linux_amd64.tar.gz" \
    && mkdir /usr/local/src/rp-indexer \
    && tar -xzf rp-indexer.tar.gz -C /usr/local/src/rp-indexer \
    \
    # Just grab the binary and ignore the other packaged files
    && mv /usr/local/src/rp-indexer/rp-indexer /usr/local/bin/ \
    && rm -rf /usr/local/src/rp-indexer rp-indexer.tar.gz \
    \
    && apt-get purge -y --auto-remove wget

EXPOSE 8080

USER rp_indexer

ENTRYPOINT []
CMD ["rp-indexer"]

