#!/bin/bash

DIR_NAME="$1"

if [ -z "$DIR_NAME" ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi
if [ ! -d "$DIR_NAME" ]; then
    echo "Directory $DIR_NAME does not exist."
    exit 1
fi

docker buildx build --tag "$DIR_NAME" --file "$DIR_NAME"/Dockerfile \
    --build-arg platform=linux/amd64 \
    --build-arg userName=mao \
    --build-arg name=$(basename "${DIR_NAME%/}") \
    .
