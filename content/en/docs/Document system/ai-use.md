---
title: "Use of AI"
linkTitle: "AI Use"
author: "Gary Dalton"
description: "Where AI sits in this document system: what it drafts, what it never decides, and the rules that keep authorship and accuracy with the author."
slug: ""
keywords: "ai, claude, drafting, workflow, authorship"
tags: ["ai", "workflow", "drafting"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
notoc: false
draft: false
weight: 40
---

## Where AI sits in the system

I use AI as a drafting and management assistant inside the workflow. The ideas, the positions, and nearly all of the published language are mine. AI accelerates the parts of the work that are mechanical: gathering research, outlining, producing first drafts, restructuring the site, and building supporting material such as datasets and figures.

## What AI does, and what I do

| Work | AI does | I do |
|---|---|---|
| Research | Collects sources, summarizes dockets and reports, and organizes reference material in the private research repository (see the [publishing workflow](/docs/document-system/publishing-workflow/)). For deep research this means multiple agents, sometimes ten at once, splitting search, analysis, and collation. | Direct the agents and triage the results. My reading queue is long, so I review the output and discard mercilessly. What survives gets verified against primary sources: every reference, figure, and dataset row. Nothing publishes with an open `[verify]` flag. |
| Argument | Assembles evidence for the positions I set. | Choose the thesis and review every argument closely. Drafts often frame positions I do not hold. The draft gets corrected, not the position. |
| Outlining | Develops a drafting outline interactively with me, often for more complex documents. | Write the document myself, from the outline. |
| Drafting | Produces first drafts against the voice guide. A draft is raw material. | Rewrite into my voice. I expect to rewrite a third of a draft or more, and for some pieces nearly all of it. My own edits are applied verbatim. |
| Editing | Works through a document with me, often line by line or paragraph by paragraph. Cleans rough passages I throw out, and makes spelling and punctuation corrections on my rewrites. | Supply the rough material, correct the cleaned version, and settle the final wording. |
| Reorganization | Restructures a document when I find it needs it: moves material within and between articles, and checks that a line in one article is not contradicted elsewhere. | Decide that a reorganization is needed, and review the moved result. |
| Site engineering | Restructures sections, builds redirects, edits configuration, and drafts documentation pages like this one, working directly in the repository. | Review every change before commit. |
| Code documentation | Reads code and documents what it does: template overrides, build scripts, and the procedures around them, in whatever language they are written. The [Theme Overrides](/docs/document-system/theme-overrides/) page is an example. | Ask the questions, and check the answers against the running site. |
| Supporting artifacts | Builds curated datasets, maps, and figures. These carry draft markings. | Verify every element before the draft marking comes off. |
| Publication | Nothing. | Decide what publishes, where, and when. |

The reader might notice a pattern in that table. Every entry in the AI column is assembly: reading, collecting, drafting, moving. Every entry in mine is judgment against ground truth: the primary sources, my positions, my voice, the running site.

The voice guide is kept in the research repository. It describes my register for each content type, the constructions I cut, and how endings work; it was derived from my published essays and from live editing sessions, and it is updated as my editing reveals patterns it does not yet capture. Drafting follows the guide; editing improves it.

## AI in the git workflow

AI tooling works directly in the repository's working tree, so the [git workflow](/docs/document-system/git-workflow/) needs its own boundaries:

- **Commits happen on my instruction, not automatically.** The tool prepares changes; I review the working tree and say when to commit. A commit made with AI assistance carries a co-author trailer, so the history records which commits had machine help.
- **I always push.** Since deployment is a push to `master`, the push is the act of publication, and it stays human. AI never pushes to this repository.
- **History is preserved deliberately.** File moves go through `git mv` so page history, and therefore the last-modified dates driven by `enableGitInfo`, survive restructuring.
- **The ignore rules are part of the safety.** `.gitignore` keeps the local research scratch folder and generated output out of the repository, so an overly broad `git add` cannot leak working drafts into a public history.

## Rules

1. AI-drafted prose is never published as delivered. It is reviewed, edited, and rewritten.
2. My corrections settle the wording. Once I have corrected a passage, AI makes spelling and punctuation fixes only.
3. The thesis is mine. I review every argument closely. AI does not determine my arguments.
4. AI-supplied facts are treated as unverified claims, no matter how confident the output sounds. Research output is triaged before it is read closely, and discarding is the default.
5. Routine drafts live on this site as `draft: true`. Work that should not be readable before publication stays in the private research repository, per the publishing workflow.
6. Generated artifacts carry a draft-and-verify marking until every element has been checked.
7. The voice guide is the contract between me and any drafting agent, and I am the only one who ratifies changes to it.

## Why work this way

Previously, I had many articles that would get stuck in drafting. Typically, I would get bogged down on citations and verifications, or an article would become so dense that it required a series instead.

I am able to write more and get more of my ideas communicated. This is especially true for the complex, structurally connected article series with multiple research points that would otherwise stall. What publishes is also more correct as language, because spelling and punctuation errors get caught before a reader sees them. The machine does assembly, and I do the thinking, the checking, and the writing that survives.
