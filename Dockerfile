# https://github.com/traefik/traefik/releases
ARG TRAEFIK_VERSION=v3.2.3

# https://hub.docker.com/_/alpine
ARG ALPINE_VERSION=3.21.0

# Official image
FROM traefik:$TRAEFIK_VERSION

# Final minimal image
FROM alpine:$ALPINE_VERSION

LABEL org.opencontainers.image.source="https://github.com/pentago/traefik-rootless"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.base.name="traefik"

RUN apk add --no-cache --no-progress ca-certificates tzdata && update-ca-certificates
RUN mkdir -p /plugins-storage/sources && chown -R 1000:1000 /plugins-storage
COPY --from=0 /usr/local/bin/traefik /usr/local/bin

USER 1000:1000
EXPOSE 8080 8443
VOLUME ["/tmp"]
ENTRYPOINT ["/usr/local/bin/traefik"]
