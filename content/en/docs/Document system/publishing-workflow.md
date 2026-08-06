---
title: "Research and Publishing Workflow"
linkTitle: "Publishing Workflow"
author: "Gary Dalton"
description: "How articles get written and published: most are drafted directly on this site, and complex or in-depth work goes through a private research repository first."
slug: ""
keywords: "workflow, publishing, hugo, git, drafts"
tags: ["publishing", "workflow", "git"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
notoc: false
draft: false
weight: 30
---

## Two paths to publication

Most articles are written directly on this site. A page starts as `draft: true` in the content tree, gets written and revised in place, and publishes when the flag flips. A second path exists for complex or in-depth work: a private research repository holds the piece until it is ready, and it arrives here only at publication. Which path a piece takes depends on one question: does it matter if someone reads the work before it is finished?

## Draft on site, the common path

1. Create the page in `content/en/` with the archetype's front matter and `draft: true`.
2. Write and revise. Preview locally with `hugo server -D --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313`; the production build ignores drafts, so nothing shows on the live site.
3. When the piece is ready, set `draft: false`, commit, and push. Render builds and deploys it.

This repository is public, so a draft here is hidden from the *site* but readable by anyone who looks at *GitHub*. For most writing, that costs nothing. A half-finished recipe or a basic essay draft sitting in the content tree harms no one.

## Offsite drafting, for complex or in-depth work

Some work should not be publicly available before publication. I have some deep research articles that may be published when completed, unconfirmed claims in working articles, preliminary data and data analyses, various in-process analyses, pieces with months of sources and revisions behind them, and articles whose value depends on landing finished. These works are drafted in private repositories instead. The `criticality-index` repository works this way, with expected publish dates measured in years, authoring documents whose publication target is this site. Any private repository can play the role.

A private repository holds everything before publication: drafts through every revision, source-verification flags, reference notes, datasets, and generated figures, with full git history that nobody else can read. This public repository then receives the finished piece as one clean commit.

In the private repository:

- Keep the front matter Docsy-ready from the start, using the same fields as this repo's `archetypes/default.md`: `title`, `linkTitle`, `author`, `description`, `keywords`, `tags`, `categories`, `date`, `draft`. A draft that already carries correct front matter publishes without rework.
- Mark unverified claims inline (for example with a `[verify]` flag next to the reference) and clear every flag before the piece leaves.
- Draft against the voice guide, described on the [Use of AI](/docs/document-system/ai-use/) page.

To publish:

1. Copy the markdown file into the appropriate place in `content/en/`.
2. Set `draft: false` and confirm the `date`.
3. Fix anything repo-relative: image references become page-bundle resources (`<name>/index.md` with an `imgs/` directory), and internal links use this site's paths.
4. Preview locally with `hugo server -D --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313`.
5. Commit and push. Render builds and deploys from `master`.

The transfer is always a copy. Pull requests only operate between branches of a single repository, or between a fork and its upstream; a private research repository is neither.

One exception to the offsite rule is a local scratch folder, `research/` in this repo's working tree. The folder is used for in-progress drafts. It is gitignored and treated as disposable. Anything worth keeping moves to the private repository, which has backup and history.
