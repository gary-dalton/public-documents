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
<!-- Scroll event listener with offset -->
@push('scripts')
    <script>
        window.addEventListener('scroll-to-element', event => {
            // Extract the payload (handle it as an array if that's how it comes through)
            const payload = Array.isArray(event.detail) ? event.detail[0] : event.detail;
            const elementId = payload.elementId;

            if (!elementId) {
                console.warn("Payload did not contain elementId. Event detail:", event.detail);
                return;
            }

            const headerOffset = 100; // Adjust this as needed

            // Function that polls for the existence of the element and scrolls to it
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
                    console.warn("Element with id", elementId, "not found after waiting.");
                }
            }

            scrollWhenElementReady();
        });
    </script>
@endpush
```

## Dispatching a Scroll Event

In your blade file

Set the id to scroll to:

```html
<div id="form_start"></div>
```

Inside a clickable element, dispatch your call:

```html
<button x-data
    @click="
        $wire.edit({{ $cat->id }});
        $dispatch('scroll-to-element', { elementId: 'form_start' });
    "
    class="bg-yellow-400 px-2 py-1 rounded mr-2">
    Edit
</button>
```

---