---
title: "Research and Publishing Workflow"
linkTitle: "Publishing Workflow"
author: "Gary Dalton"
description: "How articles move from a private research repository into this public site: drafting privately, publishing by copy, and why pull requests cannot cross the repo boundary."
slug: ""
image: ""
keywords: "workflow, publishing, hugo, git, drafts"
tags: ["publishing", "workflow", "git"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: true
weight: 30
---

## The problem this solves

This site's source repository is public, and the site depends on it staying public. The Groups section invites community groups to contribute by pull request, each page carries "Edit this page" and "Create issue" links pointing at GitHub, and the homepage welcomes contributions from all users. None of that works against a private repository without inviting every participant as a collaborator.

A public repository has one sharp edge for a writer: `draft: true` hides a page from the built site, but not from GitHub. Anyone can read a draft article sitting in the content tree. For work that should not circulate before publication, such as an article timed to a news event or analysis with unverified claims still flagged, the draft cannot live in this repository at all.

The answer is a two-repository model. Articles are drafted in a private repository and arrive here only when they are ready to be public.

## The two repositories

**The private research repository** holds everything before publication: article drafts through every revision, source-verification flags, reference notes, datasets, and generated figures. It has full git history, so nothing is lost between sessions, and none of that history is visible to anyone else.

**This public repository** holds the site: published content, theme configuration, and layouts. An article enters it as one clean commit containing the finished piece. The drafting history stays private by construction.

The `criticality-index` repository already works this way, authoring documents whose publication target is this site. Any private repository can play the research role as long as its documents carry Docsy-compatible front matter.

## Why not pull requests between the repos

Pull requests only operate between branches of a single repository, or between a fork and its upstream. A private research repository is neither, so it cannot open a pull request against this one. The transfer between repositories is always a copy.

## The workflow

### 1. Draft privately

Write and revise in the research repository. Keep the front matter Docsy-ready from the start, using the same fields as this repo's `archetypes/default.md`: `title`, `linkTitle`, `author`, `description`, `keywords`, `date`, `include_toc`, `draft`. A draft that already carries correct front matter publishes without rework.

Mark unverified claims inline (for example with a `[verify]` flag next to the reference) and clear every flag before the piece leaves the research repository.

Articles are drafted against the voice guide kept in the research repository. The guide is a living document: it was derived from published essays and editing sessions, and it gets updated as editing reveals patterns it does not yet capture. Drafting follows the guide; editing improves it.

### 2. Publish by copying

When an article is ready:

1. Copy the markdown file into the appropriate place in `content/en/`.
2. Set `draft: false` and confirm the `date`.
3. Fix anything repo-relative: image references become page-bundle resources (`<name>/index.md` with an `imgs/` directory), and internal links use this site's paths.
4. Preview locally with `hugo server -D`.
5. Commit and push. Render builds and deploys from `master`.

### 3. Optional: a review stage inside this repo

For an article that should land on a specific date, copy it onto a branch here and open a pull request from that branch to `master`. GitHub renders the diff for a final read, and the merge can wait until the intended publication morning. This pull request is within the public repository, branch to `master`, which is why it works when a cross-repo pull request does not. For routine pieces, committing directly to `master` is fine.

## Rules that keep the model honest

- Nothing unpublished is committed to this repository. Working material stays in the research repository until the moment it is published.
- A local scratch folder (`research/` in this repo's working tree) is acceptable for in-progress session work, but it must be gitignored and treated as disposable. Anything worth keeping moves to the private repository, which has backup and history.
- If a published page later moves, the old URL gets a Hugo `aliases:` entry on the page and, for previously circulated URLs, a matching 301 rule in Render.
