FROM padhihomelab/alpine-base:3.18.4_0.19.0_0.2 as base
ARG TARGETARCH

FROM base AS base-amd64
ENV RADARR_ARCH=x64

FROM base AS base-arm64
ENV RADARR_ARCH=arm64

FROM base AS base-armv7
ENV RADARR_ARCH=arm

FROM base-${TARGETARCH}${TARGETVARIANT}

ARG RADARR_VERSION=5.1.2.8207
ARG RADARR_BRANCH=develop

ADD "https://github.com/Radarr/Radarr/releases/download/v${RADARR_VERSION}/Radarr.${RADARR_BRANCH}.${RADARR_VERSION}.linux-musl-core-${RADARR_ARCH}.tar.gz" \
    /tmp/radarr.tar.gz

COPY radarr.sh \
     /usr/local/bin/radarr
COPY entrypoint-scripts \
     /etc/docker-entrypoint.d/99-extra-scripts

RUN chmod +x /etc/docker-entrypoint.d/99-extra-scripts/*.sh \
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

HEALTHCHECK --start-period=10s --interval=30s --timeout=5s \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://127.0.0.1:7878/"]
