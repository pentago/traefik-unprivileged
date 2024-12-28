# https://github.com/traefik/traefik/releases
ARG TRAEFIK_VERSION=v3.2.3

# https://hub.docker.com/_/alpine
ARG ALPINE_VERSION=3.21.0

# Official image
FROM traefik:$TRAEFIK_VERSION AS source

# Rootless customization
FROM alpine:$ALPINE_VERSION AS build
RUN apk add --no-cache --no-progress ca-certificates tzdata

# Final minimal image
FROM scratch

LABEL org.opencontainers.image.source="https://github.com/pentago/traefik-rootless"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.base.name="scratch"

COPY --from=source /usr/local/bin/traefik /
COPY --from=build /usr/share/zoneinfo /usr/share/
COPY --from=build /etc/ssl /etc/
COPY --from=build /usr/share/ca-certificates /usr/share/

USER 1000:1000
EXPOSE 8080 8443
VOLUME ["/tmp"]
ENTRYPOINT ["/traefik"]
