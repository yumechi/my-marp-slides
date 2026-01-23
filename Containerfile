FROM docker.io/marpteam/marp-cli:latest

USER root

# Install Noto Sans CJK JP (源ノ角ゴシック相当)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-noto-cjk \
    fontconfig \
    && fc-cache -fv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Stay as root for podman rootless compatibility
