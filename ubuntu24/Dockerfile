# syntax=docker/dockerfile:1

ARG platform=linux/amd64
FROM --platform=${platform} ubuntu:24.10

RUN apt-get update && apt-get install --yes \
        sudo \
        zsh \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG userName=mao
RUN useradd --create-home --shell=/bin/zsh --groups=sudo ${userName} \
    && echo "${userName} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${userName}

# Install other software
RUN apt-get update && apt-get install --yes --no-install-recommends \
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
COPY --chown=${userName} --chmod=600 \
    ${name}/.bash_aliases \
    ${name}/.zshenv \
    ${name}/.zshrc \
    ${name}/.zsh_history \
    ./
