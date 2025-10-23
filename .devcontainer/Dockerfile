# Start from the same base image
FROM mcr.microsoft.com/devcontainers/base:debian

# Install a specific, older version of Hugo directly
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends ca-certificates curl \
    && HUGO_VERSION="0.119.0" \
    && curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb" -o /tmp/hugo.deb \
    && apt-get install /tmp/hugo.deb \
    && rm /tmp/hugo.deb \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*