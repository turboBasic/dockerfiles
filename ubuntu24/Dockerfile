# syntax=docker/dockerfile:1
FROM arm64v8/ubuntu:24.10
RUN apt-get update && apt-get install --yes \
        sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG userName=mao
RUN useradd --create-home --shell=/bin/bash --groups=sudo ${userName} \
    && echo "${userName} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${userName}

# Install other software
RUN apt-get update && apt-get install --yes --no-install-recommends \
        curl \
        file \
        git \
        neovim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create and populate a data volume
ENV DATA_DIR=/data
RUN mkdir --parents "$DATA_DIR" \
    && echo "Populated in image build phase" > "$DATA_DIR"/README.txt \
    && chown --recursive ${userName}: "$DATA_DIR"
VOLUME [ "$DATA_DIR" ]

# Populate user's home directory
USER ${userName}
WORKDIR /home/${userName}

ARG name=ubuntu
COPY --chown=${userName} ${name}/.bash_aliases ./
