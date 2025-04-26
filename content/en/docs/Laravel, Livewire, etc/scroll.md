---
title: "Scroll"
date: 2025-04-26T00:00:00-05:00
weight: 18
description: "Scroll provides a way of scrolling to a specific location on the page after an event"
slug: ""
image: ""
keywords: ""
categories: 
    - ""
    - ""
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
---

# Scroll to Element

## Audience
Developers working on the Lawn Bowls Club application (or other Laravel/Livewire projects).

## Purpose
Provide consistent methods for:
- Scrolling to a page element after an action

# Scroll to an Element after a Livewire or Blade Event

## How It Works
- Use a global `scroll-to-element` event listener.
- Dispatch `scroll-to-element` with the desired `elementId`.
- The page will smooth scroll to that element with a customizable offset.

## Setup (One Time)
Push this into `@push('scripts')` in your Blade view or layout:

```html
<script>
    window.addEventListener('scroll-to-element', event => {
        const payload = Array.isArray(event.detail) ? event.detail[0] : event.detail;
        const elementId = payload.elementId;

        if (!elementId) {
            console.warn("Payload missing elementId:", event.detail);
            return;
        }

        const headerOffset = 100;
        function scrollWhenElementReady(attempts = 0) {
            const element = document.getElementById(elementId);
            if (element) {
                const elementRect = element.getBoundingClientRect();
                const elementPosition = elementRect.top + window.pageYOffset;
                const offsetPosition = elementPosition - headerOffset;
                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            } else if (attempts < 10) {
                setTimeout(() => scrollWhenElementReady(attempts + 1), 100);
            } else {
                console.warn("Element not found after 10 tries:", elementId);
            }
        }

        scrollWhenElementReady();
    });
</script>
```

## Dispatching a Scroll Event

From Blade (inside a clickable element):

```html
<tr x-data @click="$wire.dispatch('editTournamentTemplate', {id: {{ $template->id }}}); $dispatch('scroll-to-element', {elementId: 'pagetop'});">
```

---