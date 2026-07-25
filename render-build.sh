#!/usr/bin/env bash
# Render build script for werkspc.com — referenced by the Render static
# site's build command ("bash render-build.sh").
set -euo pipefail

# Full git history so enableGitInfo produces real last-modified dates
# (Render clones shallow by default). Verbose diagnostics on purpose:
# a silent failure here makes every page's date collapse to deploy day.
git config --global --add safe.directory "$(pwd)" || true
echo "git diag: shallow=$([ -f .git/shallow ] && echo yes || echo no) commits=$(git rev-list --count HEAD 2>&1) remote=$(git remote get-url origin 2>&1)"
git fetch --unshallow origin || echo "unshallow failed (exit $?)"
echo "git diag after fetch: shallow=$([ -f .git/shallow ] && echo yes || echo no) commits=$(git rev-list --count HEAD 2>&1)"

# Pin the exact Hugo (extended) version; HUGO_VERSION env var overrides.
VERSION="${HUGO_VERSION:-0.161.1}"
curl -sSL "https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_linux-amd64.tar.gz" | tar -xz hugo

# PostCSS toolchain for the Docsy asset pipeline.
npm ci

HUGO_ENV="${HUGO_ENV:-production}" ./hugo --gc
