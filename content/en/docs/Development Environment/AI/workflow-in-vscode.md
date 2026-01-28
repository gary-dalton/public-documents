---
linkTitle: "VScode"
title: "AI Multi-Engine Workflow in VS Code"
description: "Operational guide and prompt templates for GPT, Gemini, Claude, and GitHub Copilot integration in VS Code workflow."
image: ""
keywords: ""
author: "Gary Dalton"
date: 2026-01-28
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 20
---

## AI Multi-Engine Workflow Introduction

This document summarizes the operational configuration for using **GPT(ChatGPT)**,
 **Gemini**, **Claude**, and **GitHub Copilot** together in
a coordinated research and engineering workflow for modeling and code development
using **VS Code**.

## Engine Roles

<div style="overflow-x:auto;">
<table>
  <thead>
    <tr>
      <th>Engine</th>
      <th>Model</th>
      <th>Role</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>GitHub Copilot</strong></td>
      <td>GPT-4.1</td>
      <td>
        Inline coding,<br>
        refactors,<br>
        reliable Apply
      </td>
    </tr>
    <tr>
      <td><strong>ChatGPT (OpenAI)</strong></td>
      <td>GPT-5.x</td>
      <td>
        Deep reasoning,<br>
        model design,<br>
        refactor planning
      </td>
    </tr>
    <tr>
      <td><strong>Gemini Pro</strong></td>
      <td>Gemini 2.5 Pro</td>
      <td>
        Data pipeline,<br>
        schema reasoning,<br>
        ETL logic
      </td>
    </tr>
    <tr>
      <td><strong>Claude</strong></td>
      <td>Sonnet / Opus</td>
      <td>
        Architecture comprehension,<br>
        conceptual critique,<br>
        writing
      </td>
    </tr>
  </tbody>
</table>
</div>


## Operational Principle

-   **Copilot** maintains continuous full-repo awareness and applies
    edits.
-   **ChatGPT** performs high-level reasoning and mathematical/system
    design.
-   **Gemini** engineers data ingestion and validation pipelines.
-   **Claude** critiques architecture and synthesizes narrative outputs.

**Rule:** Only Copilot performs direct code application. Other engines
produce plans or diffs for manual application.

------------------------------------------------------------------------

## Prompting Guidance Per Engine

### Copilot (GPT-4.1)

Best with narrow, context-bound prompts:

    Context: Phase 0 QoG data preprocessing.

    Modify only the code in this file.
    Do not change other files.
    Do not modify raw data inputs.
    Use Julia idioms.
    Return code ready for Apply.

For discussion only:

    Context: Phase 0 QoG preprocessing.

    Explain the design or logic.
    Do not write code yet.
    Do not advance to later phases.

------------------------------------------------------------------------

### ChatGPT (GPT-5.x)

Best with structured, multi-phase reasoning instructions:

    You are assisting with Phase 0 preprocessing.
    Do not advance to later phases.
    First propose loader architecture.
    Then wait.

------------------------------------------------------------------------

### Gemini (Gemini 2.5 Pro)

Best with explicit procedural instructions:

    Write Julia code to:
    1. Load QoG CSV into DataFrame.
    2. Print schema and missingness summary.
    3. Validate country-year key uniqueness.
    4. Write Arrow partitioned by year.
    No other tasks.

------------------------------------------------------------------------

### Claude (Sonnet / Opus)

Best for conceptual and architectural critique:

    Explain the architectural implications of this pipeline.
    Do not write code yet.
    Identify conceptual risks.

------------------------------------------------------------------------

## MASTER PROMPT

### SOC Instruction Set

(The instructions here may be modified for your specific task. These were for a task I was working on.)

Paste once at the start of a ChatGPT or Claude session.

    # Task Instruction Set

    ## Role
    You are a technical research collaborator operating as an Engineer–Mathematician peer.
    Your task is to construct, test, and publish models of TASK using:

    - Self-Organized Criticality
    - Graph Theory
    - Information Theory
    - Physics-based analogs (mass, density, entropy)

    ## Active Phase
    CURRENT PHASE: Phase 0 — Data preprocessing and metadata management.

    You must not advance to later phases unless explicitly instructed.

    ## Phase Objectives

    Phase 0:
    - Design loaders for QoG CSV and Arrow data.
    - Preserve raw data immutability.
    - Define metadata and schema validation steps.

    Phase 1:
    - Define model topology and governing equations.

    Phase 2:
    - Map model concepts to data variable slugs.

    Phase 3:
    - Execute analysis strictly using mapped variables.

    Phase 4:
    - Produce publication-grade synthesis.

    ## Constraints

    - No phase skipping.
    - Use precise mathematical and graph-theoretic terminology.
    - Julia for modeling and numerics.
    - Python permitted only for IO and scaffolding.
    - Challenge assumptions that violate mathematical or physical consistency.
    - Do not modify raw source data.

    ## Style

    - Engineer-to-Engineer.
    - Dense, structured Markdown.
    - No speculative filler.

------------------------------------------------------------------------

## GEMINI SHORT FORM

Paste once per Gemini session.

    You are assisting Phase 0 data preprocessing for a QoG-based modeling project.

    Rules:
    - Do not advance beyond Phase 0.
    - Preserve raw data immutability.
    - Use Julia for data loaders and validation.
    - Provide stepwise procedures.
    - Use precise technical language.
    - No speculative discussion.

------------------------------------------------------------------------

## COPILOT LOCAL CONSTRAINT TEMPLATE

Use per Copilot request:

    Context: Phase 0 QoG data preprocessing.

    Modify only the code in this file.
    Do not change other files.
    Do not modify raw data inputs.
    Use Julia idioms.
    Return code ready for Apply.

------------------------------------------------------------------------

## OPTIONAL QUICK-TASK TEMPLATE

    Task: <one sentence>
    Scope: Only <file/function/module>.
    Output: <code / explanation / diff>.
    Constraints: Do not modify anything else.

------------------------------------------------------------------------

## Key Operating Rule

**Only one engine receives the full SOC manifesto at a time.** Copilot
always receives short, local constraints. This prevents patch
instability and context dilution.

------------------------------------------------------------------------

## Chat Session Persistance Matrix

<div style="overflow-x:auto;">
<table>
  <thead>
    <tr>
      <th>Engine</th>
      <th>Where Chats Are Stored</th>
      <th>Persistence</th>
      <th>How to Review Later</th>
      <th>Export Options</th>
      <th>Repo / File Awareness</th>
      <th>Notes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>ChatGPT (GPT-5.x subscription)</strong></td>
      <td>OpenAI account (Web, Desktop, VS Code extension)</td>
      <td><strong>Permanent until deleted</strong></td>
      <td>Chat history sidebar in ChatGPT</td>
      <td>Copy / manual export / API logging</td>
      <td>Can connect to GitHub repos or uploaded files</td>
      <td>Best long-form research record</td>
    </tr>
    <tr>
      <td><strong>Claude (Subscription)</strong></td>
      <td>Anthropic account (Web, VS Code extension)</td>
      <td><strong>Permanent until deleted</strong></td>
      <td>Claude conversation list</td>
      <td>Copy / manual export</td>
      <td>Can connect GitHub repos or uploaded files</td>
      <td>Excellent for architecture discussions</td>
    </tr>
    <tr>
      <td><strong>Gemini Pro</strong></td>
      <td>Google account (Web, VS Code extension)</td>
      <td><strong>Permanent until deleted</strong></td>
      <td>Gemini chat history panel</td>
      <td>Copy / manual export</td>
      <td>Can link GitHub repos or uploaded files</td>
      <td>Strong data-pipeline sessions</td>
    </tr>
    <tr>
      <td><strong>GitHub Copilot Chat</strong></td>
      <td>VS Code session memory only</td>
      <td><strong>Ephemeral per VS Code window</strong></td>
      <td>Visible only while window remains open</td>
      <td>Manual copy only</td>
      <td>Full continuous repo awareness</td>
      <td>Designed for transient coding assistance</td>
    </tr>
    <tr>
      <td><strong>ChatGPT VS Code Extension</strong></td>
      <td>OpenAI account</td>
      <td><strong>Permanent</strong></td>
      <td>Same ChatGPT history as web</td>
      <td>Copy / export</td>
      <td>Reads open files</td>
      <td>Persistent reasoning sessions</td>
    </tr>
    <tr>
      <td><strong>Claude VS Code Extension</strong></td>
      <td>Anthropic account</td>
      <td><strong>Permanent</strong></td>
      <td>Claude web history</td>
      <td>Copy / export</td>
      <td>Reads open files</td>
      <td>Persistent design log</td>
    </tr>
    <tr>
      <td><strong>Gemini VS Code Extension</strong></td>
      <td>Google account</td>
      <td><strong>Permanent</strong></td>
      <td>Gemini history</td>
      <td>Copy / export</td>
      <td>Reads open files</td>
      <td>Persistent pipeline log</td>
    </tr>
  </tbody>
</table>
</div>

## Summary Statement

> Copilot applies code.\
> GPT-5 designs systems.\
> Gemini engineers data pipelines.\
> Claude critiques architecture.\
> The SOC prompt governs them all.
