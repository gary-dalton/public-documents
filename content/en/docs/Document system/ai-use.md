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
draft: true
weight: 40
---

## Where AI sits in the system

I use AI as a drafting and engineering assistant inside the workflow, not as an author. The ideas, the positions, and nearly all of the published language are mine. AI accelerates the parts of the work that are assembly: gathering research, producing first drafts, restructuring the site, and building supporting material such as datasets and figures.

This page documents how that division of labor works, because a document system that uses AI without stated rules will drift toward publishing text nobody verified.

## What AI does

- **Research assembly.** Collecting sources, summarizing dockets and reports, and organizing reference material in the private research repository (see the [publishing workflow](/docs/document-system/publishing-workflow/)).
- **First drafts.** Articles are drafted against a voice guide kept in the research repository. The guide describes my register per content type, the constructions I cut, and how endings work; it was derived from my published essays and from live editing sessions. A draft is raw material; I expect to rewrite a third of it or more, and for some pieces nearly all of it.
- **Site engineering.** Section restructuring, redirects, configuration, and documentation pages like this one are done with AI tooling working directly in the repository, with changes reviewed before commit.
- **Supporting artifacts.** Curated datasets, generated maps and figures. These carry draft markings until verified.

## AI in the git workflow

AI tooling works directly in the repository's working tree, so the [git workflow](/docs/document-system/git-workflow/) needs its own boundaries:

- **Commits happen on my instruction, not automatically.** The tool prepares changes; I review the working tree and say when to commit. A commit made with AI assistance carries a co-author trailer, so the history records which commits had machine help.
- **I always push.** Since deployment is a push to `master`, the push is the act of publication, and it stays human. AI never pushes to this repository.
- **History is preserved deliberately.** File moves go through `git mv` so page history, and therefore the last-modified dates driven by `enableGitInfo`, survive restructuring.
- **The ignore rules are part of the safety.** `.gitignore` keeps the local research scratch folder and generated output out of the repository, so an overly broad `git add` cannot leak working drafts into a public history.

## What stays with me

- **The thesis.** AI does not choose what I argue. Where an early draft framed a position I do not hold, the draft was corrected, not the position.
- **Every factual claim.** AI-supplied references, figures, and dataset rows are unverified until I check them against primary sources. Drafts carry inline `[verify]` flags, and nothing publishes with an open flag.
- **The language.** My edits are applied verbatim. When my editing reveals a pattern the voice guide does not capture, the guide is updated, so the drafting improves in my direction over time. Drafting follows the guide; editing improves it.
- **Publication.** I decide what publishes, where, and when.

## Rules

1. AI-drafted prose is never published as delivered. It is edited into my voice or rewritten.
2. AI-supplied facts are treated as unverified claims, no matter how confident the draft sounds.
3. Routine drafts live on this site as `draft: true`. Work that should not be readable before publication stays in the private research repository, per the publishing workflow.
4. Generated artifacts carry a draft-and-verify marking until every element has been checked.
5. The voice guide is the contract between me and any drafting agent, and I am the only one who ratifies changes to it.

## Why work this way

The alternative approaches both fail. Refusing AI assistance discards a genuinely useful tool for assembling research and producing structured first drafts. Publishing AI output lightly edited produces text with confident errors in someone else's voice. The middle position takes discipline, which is what the rules above are for: the machine does assembly, and I do the thinking, the checking, and the writing that survives.
