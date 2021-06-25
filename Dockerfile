FROM padhihomelab/alpine-base:3.13.5_0.19.0_0.2 as base
ARG TARGETARCH

FROM base AS base-amd64
ENV RADARR_ARCH=x64

FROM base AS base-arm64
ENV RADARR_ARCH=arm64

FROM base-${TARGETARCH}${TARGETVARIANT}

ARG RADARR_VERSION=3.2.2.5080

ADD "https://github.com/Radarr/Radarr/releases/download/v${RADARR_VERSION}/Radarr.master.${RADARR_VERSION}.linux-musl-core-${RADARR_ARCH}.tar.gz" \
    /tmp/radarr.tar.gz

COPY radarr.sh       /usr/local/bin/radarr
COPY setup-volume.sh /etc/docker-entrypoint.d/setup-volume.sh

RUN chmod +x /etc/docker-entrypoint.d/setup-volume.sh \
             /usr/local/bin/radarr \
 && apk add --no-cache --update \
            icu-libs \
            libintl \
            libmediainfo \
            sqlite-libs \
            tzdata \
 && cd /tmp \
 && tar -xvzf radarr.tar.gz \
 && rm -rf Radarr/Radarr.Update \
           /tmp/radarr.tar.gz \
 && mv /tmp/Radarr /radarr

EXPOSE 7878
VOLUME [ "/config", "/downloads", "/movies" ]

CMD [ "radarr" ]

HEALTHCHECK --start-period=10s --interval=30s --timeout=5s --retries=3 \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://localhost:7878/"]
