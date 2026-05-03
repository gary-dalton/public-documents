---
title: "AI"
description: "AI is a part of every modern developer environment. Here are some ways in which I use it."
slug: ""
image: ""
keywords: ""
date: 2026-01-28
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 10
---

## Overview

This section is where I document how I use AI tools in my development workflow. 
The objective is to effectively use **AI assistance** inside the editor while keeping **execution authority, cost, and context** under control.

The currently used approach is the **Cursor and VS Code hybrid workflow**.

Cursor is used where deep multi-file reasoning and persistent AI context are required.  
VS Code remains the authoritative execution environment connected to containers, remote servers, and runtime shells.

---

## Model Access and Billing

**Web AI subscriptions ≠ API model access ≠ IDE-integrated access**

These are three different ways to think about AI access:

### **Web subscriptions**
Services like ChatGPT Plus, Claude Pro, and Gemini Advanced give you access to models in the browser.  

### **Cursor**
Cursor gives you access to multiple models *inside an IDE-like interface*. It keeps context tied to the project and remembers chats across sessions.  
Cursor plans meter usage internally based on tokens, but you don’t manually supply API keys. (it is possible but not convenient)

### **GitHub Copilot**

Copilot (used in vscode) uses a **Premium Request** system:

- Copilot Pro gives **300 premium requests per month**.
- Standard models count as **0 requests** (unlimited).
- More advanced models count against your 300 bucket.
- Heavy/experimental models can use higher multipliers.

GitHub lets you set **budgets**, monitor usage, and watch trends in the billing UI.

Internally models still operate on token context windows, but **billing is abstracted as requests**, not per-token charges.

---

## Why the Hybrid Workflow

This is the balance I need:

- **Cursor**: Keeps reasoning context and history.  
- **VS Code**: Runs code, edits files, connects to containers/remote shells.

Cursor is *my reasoning workspace*.  
VS Code is *my execution workspace*.

I keep these separate so:

- I don’t attach two editors to the same container session.
- I don’t lose Cursor’s persistent context when VS Code restarts.
- I avoid confusion about where edits originate.

| Function | Tool |
|----------|------|
| Persistent AI reasoning and multi-file refactors | Cursor |
| Code execution, containers, remote shells | VS Code |
| Runtime validation and deployment | VS Code |
| Long-running design context | Cursor |

This separation avoids attaching multiple editors to the same runtime container while maintaining continuous AI context.

---

## How These Work Together

1. I work in Cursor when I’m planning, generating, or refactoring.
2. Cursor is my go to for AI assisted multi-file, multi-function refactoring or editting/
2. When I’m ready to run, test, or validate, I switch to VS Code.
3. If I need design context back in VS Code, I bring summaries over.

This pattern keeps costs predictable and context manageable.

---

## Context Persistence

- Cursor maintains persistent conversational and project context.
- VS Code remains stateless with respect to model context.
- Long design reasoning lives in Cursor.
- Execution and testing remain in VS Code.

**Note on Copilot Chat Persistence:** VS Code stores Copilot chat history per workspace, and you can export/import sessions via VS Code commands. This is not stored in your GitHub account web history.

---

## Prompting Practices

The prompting conventions in the sub-articles remain authoritative:

- Provide explicit file paths.
- State architectural constraints early.
- Request stepwise changes, not bulk rewrites.
- Require diff-style or file-scoped outputs.
- Confirm assumptions before irreversible edits.

---

## Guides in This Section

### Cursor + VS Code Hybrid Workflow  
How I work with both editor operationally, including summary and context handoff.

→ **[Using Cursor and VS Code as a Hybrid Environment](cursor_vscode/)**

### AI Multi-Engine Workflow in VS Code  
While I am using the Cursor / Code hybrid approach, the information in this is still relevant as it talks about the different agents and their data peristance.

→ **[AI Multi-Engine Workflow in VS Code](workflow-in-vscode/)**

### Optimizing AI Usage and Cost Control  
Managing context windows, request budgets, and token efficiency in the hybrid workflow.

→ **[Optimizing Hybrid AI Usage](optimization/)**

---

## Guiding Principle

**AI is treated as an interactive reasoning instrument — not an autonomous code generator.**  
Execution authority always remains with the human operator and the runtime environment.
