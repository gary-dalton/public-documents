---
title: "Toastr"
date: 2025-04-26T00:00:00-05:00
weight: 16
description: "Toastr is a javascript method of popping up an alert notification to the user. It uses jquery and has good styling and functionality."
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

# Toastr Notifications and Redirects

## Audience
Developers working on the Lawn Bowls Club application (or other Laravel/Livewire projects).

## Purpose
Provide consistent methods for:
- Triggering toast notifications
- Redirecting users after a delay while locking the page

---

# Global Toastr Notifications via Custom Events

## How It Works
- Dispatch a `toast` CustomEvent.
- A global script listens and fires Toastr.
- No direct `toastr.success()` calls from Blade or Livewire.

## Global Toastr Listener Setup (already exists)

```html
<script>
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "timeOut": 4500,
    };

    window.addEventListener('toast', event => {
        const detail = Array.isArray(event.detail) ? event.detail[0] : event.detail;
        if (typeof toastr[detail.alertType] === 'function') {
            toastr[detail.alertType](detail.alertMessage);
        }
    });
</script>
```

## Dispatching a Toast

From Blade:

```javascript
window.dispatchEvent(new CustomEvent('toast', {
    detail: {
        alertType: 'success',
        alertMessage: 'Your notifications have been saved!'
    }
}));
```

From Livewire PHP component:

```php
$this->dispatch('toast', [
    'alertType' => 'success',
    'alertMessage' => 'Template updated successfully!',
]);
```

---

# Redirect with Toastr Notification and Page Lock

## Goal
- Disable page interaction.
- Show a toast notification.
- Redirect after a delay.

## Helper Function

```html
<script>
    function autoRedirectWithToast(url, message = 'Redirecting...', alertType = 'success', delayMs = 3000) {
        document.body.style.pointerEvents = 'none';
        document.body.style.opacity = '0.5';

        window.dispatchEvent(new CustomEvent('toast', {
            detail: {
                alertType: alertType,
                alertMessage: message,
            }
        }));

        setTimeout(() => {
            window.location.href = url;
        }, delayMs);
    }
</script>
```

## Usage on Page Load

```html
<script>
    document.addEventListener('DOMContentLoaded', function() {
        autoRedirectWithToast('{{ route('dashboard') }}', 'Redirecting you to the dashboard...', 'info', 3000);
    });
</script>
```

---


