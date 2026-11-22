# Start from the same base image
FROM mcr.microsoft.com/devcontainers/base:debian

# Install Go and Hugo (Node comes from the devcontainer Node feature)
# Keep HUGO_VERSION in sync with the pin in render-build.sh so local dev
# matches production. Newer Hugo releases change defaults (e.g. blocking
# .html content files) and must be tested before bumping both.
ARG HUGO_VERSION=0.161.1
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends golang ca-certificates curl \
    && curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb" -o /tmp/hugo.deb \
    && apt-get install /tmp/hugo.deb \
    && rm /tmp/hugo.deb \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
