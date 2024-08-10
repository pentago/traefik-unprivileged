# https://github.com/traefik/traefik/releases
ARG TRAEFIK_VERSION=v3.1.1

# https://hub.docker.com/_/alpine
ARG ALPINE_VERSION=3.20.2

# Official image
FROM traefik:$TRAEFIK_VERSION AS source

# Rootless customization
FROM alpine:$ALPINE_VERSION AS build
COPY --from=source /usr/local/bin/traefik /

# Modification to allow running rootless while listening on low ports
# RUN apk --no-cache add libcap
# RUN setcap cap_net_bind_service=+ep /traefik

# Final minimal image
FROM scratch

LABEL org.opencontainers.image.source="https://github.com/pentago/traefik-rootless"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.base.name="scratch"

COPY --from=source /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=source /usr/share/zoneinfo /usr/share/
COPY --from=build /traefik /

USER 1000:1000
EXPOSE 8080 8443
VOLUME ["/tmp"]
ENTRYPOINT ["/traefik"]
