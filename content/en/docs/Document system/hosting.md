---
title: "Hosting"
linkTitle: "Hosting"
author: "Gary Dalton"
description: "How werkspc.com is hosted: a Render static site that builds from source on every push, with a build script that pins Hugo and repairs the shallow checkout."
slug: ""
image: ""
keywords: "hosting, render, deployment, hugo, static site"
tags: ["hosting", "hugo", "render"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: true
weight: 20
---

## The model

werkspc.com is a [Render](https://render.com/) static site. Render watches the GitHub repository, and every push to `master` triggers a build from source: there is no local production build step, and the generated `public/` directory is never committed. Deployment is therefore identical to pushing, which keeps the [git workflow](/docs/document-system/git-workflow/) the only workflow.

The site's DNS is managed at Cloudflare, with the domain pointed at Render.

## The build

Render's dashboard build command is intentionally minimal:

```bash
bash render-build.sh
```

All real logic lives in `render-build.sh` at the repository root, for two reasons: the build steps are versioned alongside the site instead of living only in a dashboard field, and Render's API firewall rejects build commands containing patterns like `curl … | tar`, which the script needs.

The script does four things:

1. **Unshallows the git checkout.** Render clones only the latest commit and configures no git remote. The script fetches full history from the explicit GitHub URL because the site sets `enableGitInfo = true` — without full history, every page's "last modified" date collapses to the deploy date. A failure here is logged loudly rather than fatally.
2. **Pins Hugo.** It downloads exactly Hugo extended 0.161.1 (overridable with a `HUGO_VERSION` environment variable), so a Render-side default change can never silently alter the build.
3. **Restores the Node toolchain.** `npm ci` installs the PostCSS pipeline that the Docsy theme's asset processing requires, exactly as locked in `package-lock.json`.
4. **Builds.** `HUGO_ENV=production ./hugo --gc`. Production builds exclude drafts, so nothing marked `draft: true` can reach the live site regardless of what the local preview shows.

The Docsy theme itself needs no network or Go toolchain at build time because it is vendored into `_vendor/` and committed.

## Redirects

When a published page moves, two layers keep the old URL working:

- A Hugo `aliases:` entry in the page's front matter generates a redirect stub at the old path. This ships with the site automatically.
- For URLs that circulated externally, a matching 301 rule in Render's dashboard (Redirects/Rewrites) provides a true HTTP redirect. Rules support wildcards, for example `/local/economy/datacenters/*` → `/policy/datacenters/*`.

## Things to know

- Build problems surface in Render's deploy logs; the build script's git diagnostics line (`shallow=… commits=…`) is the first thing to check when page dates look wrong.
- The Hugo version pin should move deliberately, together with theme upgrades, after testing locally.
- Render never builds drafts, so `hugo server -D` locally is always safe — showing a draft on your own screen cannot leak it to production.
