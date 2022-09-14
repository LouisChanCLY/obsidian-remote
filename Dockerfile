FROM ghcr.io/linuxserver/baseimage-rdesktop-web:focal

ARG BUILDARCH

LABEL org.opencontainers.image.authors="github@sytone.com"
LABEL org.opencontainers.image.source="https://github.com/sytone/obsidian-remote"
LABEL org.opencontainers.image.title="Container hosted Obsidian MD"
LABEL org.opencontainers.image.description="Hosted Obsidian instance allowing access via web browser"

RUN \
    echo "**** install packages ****" && \
        # Update and install extra packages.
        apt-get update && \
        apt-get install -y --no-install-recommends \
            # Packages needed to download and extract obsidian.
            curl \
            libnss3 \
            # Install Chrome dependencies.
            dbus-x11 \
            uuid-runtime && \
    echo "**** cleanup ****" && \
        apt-get autoclean && \
        rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

# # set version label
ARG OBSIDIAN_VERSION=0.15.9

COPY download-obsidian.sh ./
RUN echo "**** download and extract obsidian ****"
RUN chmod +x download-obsidian.sh && ./download-obsidian.sh

RUN echo "**** set up obsidian ****"
ENV \
    CUSTOM_PORT="8080" \
    GUIAUTOSTART="true" \
    HOME="/vaults" \
    TITLE="Obsidian v$OBSIDIAN_VERSION"

# add local files
COPY root/ /

EXPOSE 8080
EXPOSE 27123
EXPOSE 27124
VOLUME ["/config","/vaults"]


