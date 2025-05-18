# syntax=docker/dockerfile:1

ARG platform=linux/amd64
FROM --platform=${platform} ubuntu:24.10

# Set up basics, locales and timezone
RUN apt-get update && apt-get install --yes \
        locales \
        sudo \
        tzdata \
        zsh \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && locale-gen de_DE.UTF-8 en_DK.UTF-8 en_GB.UTF-8 en_US.UTF-8 \
    && update-locale LANG=en_DK.UTF-8 \
    && ln --symbolic --force /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user
ARG userName=mao
RUN useradd --create-home --shell=/bin/zsh --groups=sudo ${userName} \
    && echo "${userName} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${userName}

# Install other software
RUN apt-get update && apt-get install --yes --no-install-recommends \
        apt-file \
        ca-certificates \
        curl \
        file \
        git \
        jq \
        less \
        neovim \
        ripgrep \
        tree \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create and populate a data volume
ENV DATA_DIR=/data
RUN mkdir --parents "$DATA_DIR" \
    && echo "Populated in image build phase" > "$DATA_DIR"/README.md \
    && chown --recursive ${userName}: "$DATA_DIR"
VOLUME [ "$DATA_DIR" ]

# Populate user's home directory
USER ${userName}
CMD [ "/bin/zsh" ]
WORKDIR /home/${userName}

ARG name=ubuntu24
COPY --chown=${userName} ${name}/home ./
RUN chmod g-rwx,o-rwx .bash* .zsh*
