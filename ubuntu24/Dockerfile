# syntax=docker/dockerfile:1

ARG platform=linux/amd64
FROM --platform=${platform} ubuntu:24.10

# Install basics, locales and timezone
RUN apt-get update && apt-get install --yes \
        locales \
        sudo \
        tzdata \
        zsh \
    `# will not clean up apt cache so that apt-file can be used without updating` \
    `# && apt-get clean && rm -rf /var/lib/apt/lists/*` \
    && locale-gen de_DE.UTF-8 en_DK.UTF-8 en_GB.UTF-8 en_US.UTF-8 \
    && update-locale LANG=en_DK.UTF-8 \
    && ln --symbolic --force /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

# Create a non-root user
ARG userName=mao
RUN useradd --create-home --shell=/bin/zsh --groups=sudo ${userName} \
    && echo "${userName} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${userName}

# Install other software
RUN apt-get install --yes --no-install-recommends \
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
        unzip \
        `# last line`

# Create and populate a data volume
ENV DATA_DIR=/data
RUN mkdir --parents "$DATA_DIR" \
    && echo "Populated in image build phase" > "$DATA_DIR"/README.md \
    && chown --recursive ${userName}: "$DATA_DIR"
VOLUME [ "$DATA_DIR" ]

# Set up locale and timezone
ARG timezone=Europe/Berlin
ARG locale=en_DK.UTF-8
RUN locale-gen ${locale} \
    && update-locale LANG=${locale} \
    && ln --symbolic --force /usr/share/zoneinfo/${timezone} /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

# Populate user's home directory
USER ${userName}
ENTRYPOINT [ "/usr/bin/zsh", "--interactive", "-c" ]
CMD [ "zsh" ]
WORKDIR /home/${userName}
RUN mkdir --mode 700 .ssh

# Install Bitwarden CLI
ARG bwVersion=2025.4.0
RUN curl --location --remote-name \
      "https://github.com/bitwarden/clients/releases/download/cli-v${bwVersion}/bw-linux-${bwVersion}.zip" \
    && mkdir --parents .local/bin \
    && unzip "bw-linux-${bwVersion}.zip" -d .local/bin \
    && rm -f "bw-linux-${bwVersion}.zip"

ARG name=ubuntu24
COPY --chown=${userName} ${name}/home ./
RUN chmod g-rwx,o-rwx .bash* .zsh*
