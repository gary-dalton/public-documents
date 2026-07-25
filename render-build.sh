#!/usr/bin/env bash
# Render build script for werkspc.com — referenced by the Render static
# site's build command ("bash render-build.sh").
set -euo pipefail

# Full git history so enableGitInfo produces real last-modified dates
# (Render clones shallow by default).
git fetch --unshallow -q || true

# Pin the exact Hugo (extended) version; HUGO_VERSION env var overrides.
VERSION="${HUGO_VERSION:-0.161.1}"
curl -sSL "https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_linux-amd64.tar.gz" | tar -xz hugo

# PostCSS toolchain for the Docsy asset pipeline.
npm ci

HUGO_ENV="${HUGO_ENV:-production}" ./hugo --gc
