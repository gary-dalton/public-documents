---
title: "Git Workflow"
linkTitle: "Git Workflow"
author: "Gary Dalton"
description: "How this site uses git: the repository, the edit-preview-commit cycle, why commit history matters for page dates, and what never gets committed."
slug: ""
keywords: "git, github, version control, workflow"
tags: ["git", "workflow"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
notoc: false
draft: false
weight: 10
---

## The repository

The entire site lives in one public GitHub repository, [gary-dalton/public-documents](https://github.com/gary-dalton/public-documents). Git provides three things here: versioning for every document, transfer between working machines and the host, and the trigger for deployment. Every push to `master` causes a fresh build of the live site (see [Hosting](/docs/document-system/hosting/)).

If you need to install git first, see [the development environment instructions](/docs/development-environment/git/).

## The working cycle

Routine work is a short loop:

1. Edit content in `content/en/`.
2. Preview locally with drafts visible:
   ```bash
   hugo server -D --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313
   ```
3. Commit with a message that says what changed and why.
4. Push to `master`. The host then builds and deploys automatically.

Publication is controlled entirely by the front matter: a page with `draft: true` renders in the local preview (because of the `-D` flag) but is excluded from the production build. Flipping `draft: false` and pushing is the **act of publishing**.

AI tooling works inside this cycle under fixed boundaries: it prepares changes in the working tree, commits only on my instruction with a co-author trailer, and never pushes. The push, and therefore publication, stays human. The full rules are on the [Use of AI](/docs/document-system/ai-use/) page.

## Commit history is the page's metadata

The site's config sets `enableGitInfo = true`, which means the "last modified" date shown on each page comes from that file's most recent git commit. Two workflow habits follow from this:

- Commit related changes together, so a page's last-modified date reflects a real content change.
- Avoid bulk reformatting commits that touch many files, since every touched page will advertise a new modification date.

## Branches and pull requests

Routine work goes straight to `master`. Branches exist for outside contributors (see the [Groups section](/groups/)), who work on branches or forks and open pull requests. I then review those before merging.

## What never gets committed

The `.gitignore` keeps generated and private material out of the repository:

- `public/`: the built site. Every Hugo build writes the complete rendered site here: every page as HTML, plus the compiled CSS, processed images, and feeds. It is pure output, fully regenerable from source at any time, so committing it would store a second copy of the site that carries no information the source does not. Worse, that copy goes stale the moment any source file changes, and it churns on every build. Thousands of generated files would appear in every diff, burying the real changes. None of it would even be used, because Render builds fresh from source on every deploy and never reads a committed `public/`. This repository did track `public/` in its GitHub-hosted era; the move to full Render-side builds made the committed copy dead weight, and it was untracked in 2026.
- `resources/` (repo root): Hugo's asset cache, regenerated on every build.
- `node_modules/`: restored by `npm ci` from `package-lock.json`.
- Research notes and sensitive pre-publication work. Because the repository is public, everything committed here is world-readable regardless of `draft:` status. Routine article drafts live here as `draft: true` and that visibility is fine; work that should not circulate before publication stays in a private repository, as described in the [publishing workflow](/docs/document-system/publishing-workflow/).
