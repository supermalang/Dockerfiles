FROM debian:buster-slim

RUN set -ex \
    && addgroup --system rp_archiver \
    && adduser --system --ingroup rp_archiver rp_archiver

# Install ca-certificates so HTTPS works in general
RUN apt-get update  \
    && apt-get install -y --no-install-recommends ca-certificates wget  \
    && rm -rf /var/lib/apt/lists/*

ARG RP_ARCHIVER_REPO=nyaruka/rp-archiver
ENV RP_ARCHIVER_REPO=${RP_ARCHIVER_REPO}
ARG RP_ARCHIVER_VERSION=7.0.0
ENV RP_ARCHIVER_VERSION=${RP_ARCHIVER_VERSION}

RUN set -ex \
    && wget -O archiver.tar.gz "https://github.com/$RP_ARCHIVER_REPO/releases/download/v${RP_ARCHIVER_VERSION}/rp-archiver_${RP_ARCHIVER_VERSION}_linux_amd64.tar.gz" \
    && mkdir /usr/local/src/archiver \
    && tar -xzf archiver.tar.gz -C /usr/local/src/archiver \
    \
    # Just grab the binary and ignore the other packaged files
    && mv /usr/local/src/archiver/rp-archiver /usr/local/bin/ \
    && rm -rf /usr/local/src/archiver archiver.tar.gz \
    && apt-get purge -y --auto-remove 

EXPOSE 8080

USER rp_archiver

ENTRYPOINT []
CMD ["rp-archiver"]
