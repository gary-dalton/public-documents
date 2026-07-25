# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

The Hugo source for [werkspc.com](https://werkspc.com/) — Gary Dalton's personal documentation and blog site (how-tos, tutorials, blog, group pages). Runs in a dev container (see `.devcontainer/`) with Hugo extended + Node/PostCSS.

## Workflow & commands

**Deploys are Render-built**: push to `master` and Render runs `bash render-build.sh` (pins Hugo extended 0.161.1, `npm ci`, production build). There is no local production build step and `public/` is gitignored — never commit generated output.

```bash
# Dev server; -D shows drafts locally (safe: Render never builds drafts)
hugo server -D --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313
```

- Publication is controlled purely by front-matter `draft:` at push time.
- Git workflow: commit only when asked; **never push** — Gary always pushes.
- `render-build.sh` notes: Render's checkout is shallow with **no git remote**, so the script unshallows from the explicit GitHub URL — required for `enableGitInfo` last-modified dates. Render's API WAF rejects build commands containing `curl|tar`, which is why the logic lives in this script and the dashboard command is just `bash render-build.sh`.

## Theme architecture (Docsy, vendored)

Docsy is a Hugo Module pinned in `go.mod` and **vendored into `_vendor/`** (committed), so builds need no Go toolchain or network. `themes/docsy/` is an empty leftover directory — ignore it.

- Upgrade flow: `hugo mod get github.com/google/docsy@<version> && hugo mod vendor`, then **delete `_vendor/**/package.json`** (Dependabot otherwise raises false alerts for Bootstrap's/Docsy's own dev dependencies), test locally, commit.
- Known: Docsy ≤0.15.0 emits a harmless `.Language.LanguageDirection` deprecation warning at build — upstream issue, no local action.
- Customize by **shadowing**, never by editing `_vendor/`:
  - `layouts/` overrides theme templates — currently `blog/list.html`, `blog/single.html`, `partials/toc.html`, `404.html`, plus custom shortcodes (`last-updated`, `feature-row`, `lastmod-debug`).
  - `assets/scss/_variables_project.scss` / `_styles_project.scss` override theme SCSS. The navbar-logo `currentColor` rule in `_styles_project.scss` exists because Docsy 0.14+ made the navbar background theme-aware while `assets/icons/logo.svg` is hard-coded white — keep it.

## Content structure

All content lives under `content/en/` (set by `contentDir` in `hugo.toml`): `about/`, `blog/`, `docs/`, `groups/` (e.g. lawn-bowls), `local/`.

- Blog permalinks are date-based: `/blog/:year/:month/:day/:slug/`.
- Front matter convention is `archetypes/default.md`: `title`, `linkTitle`, `author`, `description`, `slug`, `keywords`, `date`, `include_toc`, `show_comments`; new content starts `draft: true`.
- Pages with their own images are **page bundles** (`<name>/index.md` + `imgs/` inside) with `./imgs/...` refs — works for both Hugo and Marp export (see `groups/lawn-bowls/ladder-challenge/`).
- `hugo.toml` is the single config file; `enableGitInfo = true`, so last-modified dates come from git history. The site description must stay under `[languages.en.params]` — at the language top level Hugo silently drops it and pages ship empty meta descriptions.

## Cross-repo relationship

`gary-dalton/criticality-index` (separate repo, has its own CLAUDE.md) authors research documents whose publication target is this site — its docs arrive with Docsy-compatible YAML front matter (`title`, `linkTitle`, `description`, `author`, `date`, `keywords`, `include_toc`, `draft`) and are published under this repo's content tree.
