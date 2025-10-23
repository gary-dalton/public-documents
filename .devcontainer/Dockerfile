# Start from the same base image
FROM mcr.microsoft.com/devcontainers/base:debian

<<<<<<< HEAD
# Install a specific, older version of Hugo directly
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends ca-certificates curl \
    && HUGO_VERSION="0.119.0" \
    && curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb" -o /tmp/hugo.deb \
    && apt-get install /tmp/hugo.deb \
    && rm /tmp/hugo.deb \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
=======
# Install Go, Node.js, and then Hugo
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends golang nodejs npm ca-certificates curl \
    && HUGO_VERSION=$(curl -s "https://api.github.com/repos/gohugoio/hugo/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+') \
    && curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb" -o /tmp/hugo.deb \
    && apt-get install /tmp/hugo.deb \
    && rm /tmp/hugo.deb \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Copy package.json and install Node.js dependencies
COPY package.json .
RUN npm install
>>>>>>> 0379eb4b007a5b84bf2be4d42b39bf71e6da026b
