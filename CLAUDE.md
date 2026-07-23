# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

The Hugo source for [werkspc.com](https://werkspc.com/) — Gary Dalton's personal documentation and blog site (how-tos, tutorials, blog, group pages). Runs in a dev container (see `.devcontainer/`) with Hugo extended + Node/PostCSS.

## Commands

```bash
# Dev server (poll-based watching is required under the WSL2 dev container)
hugo server --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313

# Production build (regenerates public/)
HUGO_ENV="production" hugo --gc
```

- `public/` is **committed generated output** — never hand-edit it; rebuild with Hugo. The live site (werkspc.com, served by Render behind Cloudflare) is built from it, so a production build must never include drafts (`-D`).
- Git workflow: commit only when asked; **never push** — Gary always pushes.

## Theme architecture (Docsy via Hugo Modules)

The Docsy theme is **not** in the repo. It's a Hugo module pinned in `go.mod` (with `github.com/google/docsy/dependencies` for Bootstrap/FontAwesome), downloaded to the Hugo module cache inside the container. `themes/docsy/` is an empty leftover directory — ignore it.

- Upgrade: `hugo mod get github.com/google/docsy@<version>`, then test-build. Known: Docsy ≤0.15.0 emits a harmless `.Language.LanguageDirection` deprecation warning — upstream issue, no local action.
- Customize by **shadowing**, never by editing the module cache:
  - `layouts/` overrides theme templates — currently `blog/list.html`, `blog/single.html`, `partials/toc.html`, `404.html`, plus custom shortcodes (`last-updated`, `feature-row`, `lastmod-debug`).
  - `assets/scss/_variables_project.scss` / `_styles_project.scss` override theme SCSS. The navbar-logo `currentColor` rule in `_styles_project.scss` exists because Docsy 0.14+ made the navbar background theme-aware while `assets/icons/logo.svg` is hard-coded white — keep it.

## Content structure

All content lives under `content/en/` (set by `contentDir` in `hugo.toml`): `about/`, `blog/`, `docs/`, `groups/` (e.g. lawn-bowls), `local/`.

- Blog permalinks are date-based: `/blog/:year/:month/:day/:slug/`.
- Front matter convention is `archetypes/default.md`: `title`, `linkTitle`, `author`, `description`, `slug`, `keywords`, `date`, `include_toc`, `show_comments`; new content starts `draft: true`.
- `hugo.toml` is the single config file; `enableGitInfo = true`, so last-modified dates come from git history.

## Cross-repo relationship

`gary-dalton/criticality-index` (separate repo, has its own CLAUDE.md) authors research documents whose publication target is this site — its docs arrive with Docsy-compatible YAML front matter (`title`, `linkTitle`, `description`, `author`, `date`, `keywords`, `include_toc`, `draft`) and are published under this repo's content tree.
