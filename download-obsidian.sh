#!/bin/bash

echo $BUILDARCH
echo $OBSIDIAN_VERSION
if [[ "$BUILDARCH" == "arm64" ]];
then
    curl \
    https://github.com/obsidianmd/obsidian-releases/releases/download/v$OBSIDIAN_VERSION/Obsidian-$OBSIDIAN_VERSION-arm64.AppImage \
    -L \
    -o obsidian.AppImage;
else
    curl \
    https://github.com/obsidianmd/obsidian-releases/releases/download/v$OBSIDIAN_VERSION/Obsidian-$OBSIDIAN_VERSION.AppImage \
    -L \
    -o obsidian.AppImage;
fi

echo "**** extract obsidian ****" && \
    chmod +x /obsidian.AppImage && \
    /obsidian.AppImage --appimage-extract
