---
title: "Git Workflow"
linkTitle: "Git Workflow"
author: "Gary Dalton"
description: "How this site uses git: the repository, the daily edit-preview-commit cycle, why commit history matters for page dates, and what never gets committed."
slug: ""
image: ""
keywords: "git, github, version control, workflow"
tags: ["git", "workflow"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: true
weight: 10
---

## The repository

The entire site lives in one public GitHub repository, [gary-dalton/public-documents](https://github.com/gary-dalton/public-documents). Git provides three things here: versioning for every document, transfer between working machines and the host, and the trigger for deployment — every push to `master` causes a fresh build of the live site (see [Hosting](/docs/document-system/hosting/)).

If you need to install git first, see [the development environment instructions](/docs/development-environment/git/).

## The daily cycle

Routine work is a short loop:

1. Edit content in `content/en/`.
2. Preview locally with drafts visible:
   ```bash
   hugo server -D --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313
   ```
3. Commit with a message that says what changed and why.
4. Push to `master`. The host builds and deploys automatically.

Publication is controlled entirely by front matter: a page with `draft: true` renders in the local preview (because of the `-D` flag) but is excluded from the production build. Flipping `draft: false` and pushing is the act of publishing.

## Commit history is page metadata

The site config sets `enableGitInfo = true`, which means the "last modified" date shown on each page comes from that file's most recent git commit. Two habits follow from this:

- Commit related changes together, so a page's last-modified date reflects a real content change.
- Avoid bulk reformatting commits that touch many files, since every touched page will advertise a new modification date it did not earn.

## Branches and pull requests

Day-to-day work goes straight to `master`. A branch is worth the ceremony in two cases:

- **Timed publication.** Put a finished article on a branch, open a pull request against `master`, and merge on the morning it should go live. GitHub renders the diff for a final review, and the merge is the publish action.
- **Contributions.** Outside contributors (see the [Groups section](/groups/)) work on branches or forks and open pull requests, which I review before merge.

## What never gets committed

The `.gitignore` keeps generated and private material out of the repository:

- `public/` — the built site. The host builds from source; committed output would only drift stale.
- `resources/` (repo root) — Hugo's asset cache, regenerated on every build.
- `node_modules/` — restored by `npm ci` from `package-lock.json`.
- Working drafts and research notes. Because the repository is public, anything committed here is world-readable regardless of `draft:` status — pre-publication work stays in a private repository, as described in the [publishing workflow](/docs/document-system/publishing-workflow/).
