FROM golang:1.17-buster

RUN set -ex; \
    addgroup --system courier; \
    adduser --system --ingroup courier courier

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ARG COURIER_REPO=nyaruka/courier
ENV COURIER_REPO=${COURIER_REPO}
ARG COURIER_VERSION=7.0.0
ENV COURIER_VERSION=${COURIER_VERSION}

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --depth 1 "https://github.com/$COURIER_REPO.git" \
    && cd courier \
    && go build "github.com/$COURIER_REPO"/cmd/courier  \
    && cp courier /go/bin \ 
    && apt-get purge -y --auto-remove 

EXPOSE 8080

USER courier

ENTRYPOINT []
CMD ["courier"]

