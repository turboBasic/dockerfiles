# Dockerfiles

This repository contains a collection of Dockerfiles, each organized into its own subdirectory. These are used for various development and testing environments.

## Usage

```bash
./build.sh $directoryName $imageTag:$baseVersion
# for example, build image in `ubuntu` dir from ubuntu:25.04 image and give it `ubuntu25` tag
./build.sh ubuntu ubuntu25:25.04
```


## Available Dockerfiles

Below is a list of the available Dockerfile configurations:

*   **[ubuntu](./ubuntu/)**: A Dockerfile for an Ubuntu environment tailored for ARM64, including common utilities and a non-root user.

Feel free to explore each subdirectory for specific details, build instructions, and usage.
