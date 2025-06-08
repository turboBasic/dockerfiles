#!/bin/bash

DIR_NAME="$1"
TAG="${2:-$1}"
LOCALE="${3:-en_DK.UTF-8}"
TIMEZONE="${4:-Europe/Berlin}"

if [ -z "$DIR_NAME" ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi
if [ ! -d "$DIR_NAME" ]; then
    echo "Directory $DIR_NAME does not exist."
    exit 1
fi

image_tag="${TAG%:*}"
image_version="${TAG#*:}"  # Replace slashes with dashes for Docker tag compatibility
docker buildx build \
    --platform=linux/amd64 \
    --tag "$image_tag" \
    --file "$DIR_NAME"/Dockerfile \
    --build-arg version="$image_version" \
    --build-arg locale="$LOCALE" \
    --build-arg timezone="$TIMEZONE" \
    --build-arg userName=mao \
    --build-arg homeDir="$(basename "${DIR_NAME%/}")/home" \
    .
