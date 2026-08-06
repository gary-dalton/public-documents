---
title: "Hosting"
linkTitle: "Hosting"
author: "Gary Dalton"
description: "How werkspc.com is hosted: Render builds the site from source on every push, using a build script that sets the exact Hugo version and fetches full git history so page dates stay correct."
slug: ""
keywords: "hosting, render, deployment, hugo, static site"
tags: ["hosting", "hugo", "render"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
notoc: false
draft: false
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

[`render-build.sh`](https://github.com/gary-dalton/public-documents/blob/master/render-build.sh) is my own script, not something Render provides or requires. I wrote it for this site, it is committed at the repository root, and Render's only involvement is running the command above. The filename is my convention, and changing the build means editing this file and committing, like any other change.

All real logic lives in the script for two reasons: the build steps are versioned alongside the site instead of living only in a dashboard field, and Render's API firewall rejected this site's build command when it contained patterns like `curl … | tar`, which the build needs. Other sites can run such commands inline when the firewall does not intervene; this one could not.

The script does four things:

1. **Unshallows the git checkout.** Render clones only the latest commit and configures no git remote. The script fetches full history from the explicit GitHub URL because the site sets `enableGitInfo = true`. Without full history, every page's "last modified" date collapses to the deploy date. A failure here is logged loudly rather than fatally.
2. **Pins Hugo.** It downloads exactly the pinned Hugo extended version (shown below; overridable with a `HUGO_VERSION` environment variable), so a Render-side default change can never silently alter the build.
3. **Restores the Node toolchain.** `npm ci` installs the PostCSS pipeline that the Docsy theme's asset processing requires, exactly as locked in `package-lock.json`.
4. **Builds.** `HUGO_ENV=production ./hugo --gc`. Production builds exclude drafts, so nothing marked `draft: true` can reach the live site regardless of what the local preview shows.

The Docsy theme itself needs no network or Go toolchain at build time because it is vendored into `_vendor/` and committed.

## Bumping the Hugo version

The pin lives on one line of `render-build.sh`:

```bash
VERSION="${HUGO_VERSION:-0.161.1}"
```

The dev container is not pinned. Its Dockerfile installs the latest Hugo extended at image build time, so the container naturally runs ahead of production. That drift is fine and expected. The pin moves only when a Docsy upgrade requires a newer Hugo than the pinned version; there is no reason to chase Hugo releases on their own. When a bump is required:

1. Rebuild the dev container (Command Palette, "Dev Containers: Rebuild Container"). The rebuilt container carries the current Hugo release.
2. Run `hugo version` inside the container and note the version.
3. Set the default in the `VERSION=` line of `render-build.sh` to that version.
4. Check the Render dashboard for a `HUGO_VERSION` environment variable. It overrides the script default, so if one is set, update it or remove it.
5. Build the full site locally and watch for errors and new deprecation warnings before committing.

The local check at bump time matters in both directions: a production Hugo newer than local can reject what the preview accepted, and a local Hugo newer than production can accept what the deploy then rejects.

## Redirects

When a published page moves, two layers keep the old URL working:

- A Hugo `aliases:` entry in the page's front matter generates a redirect stub at the old path. This ships with the site automatically.
- For URLs that circulated externally, a matching 301 rule in Render's dashboard (Redirects/Rewrites) provides a true HTTP redirect. Rules support wildcards, for example `/local/economy/datacenters/*` → `/policy/datacenters/*`.

## Things to know

- Build problems surface in Render's deploy logs; the build script's git diagnostics line (`shallow=… commits=…`) is the first thing to check when page dates look wrong.
- The Hugo version pin moves only when a theme upgrade requires it, following the bump procedure above.
- Render never builds drafts, so `hugo server -D` locally is always safe. Showing a draft on your own screen cannot leak it to production.
