---
title: "Livewire Orchestration Pattern (LOP)"
date: 2025-05-13T00:00:00-05:00
weight: 4
description: "This is my enhanced version of MVC to better leverage livewire. It adds an Orchestrator to handle complex logic and views. "
slug: ""
image: ""
keywords: "laravel, livewire, architecture, design pattern, mvc, full-page components"
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

# Livewire Orchestration Pattern (LOP)

## Audience
Developers working on the Lawn Bowls Club application (or other Laravel/Livewire projects).

## Purpose
This document outlines the "Livewire Orchestration Pattern" (LOP), a file and component structure designed to effectively build and manage sophisticated features using Livewire. It explains each component of the pattern and how they interact.

---

# Core Concepts

The LOP extends the traditional Model-View-Controller (MVC)  paradigm by explicitly recognizing the controller role of Livewire components and introducing the Orchestrator and Wrapper layers for structuring complex, interactive UIs in Laravel.

* **Model (M):** Standard Laravel Eloquent models representing application data and business logic. [Laravel's Eloquent Model](https://laravel.com/docs/10.x/eloquent)
* **View (V):** Blade templates. These include:
    * The main application layouts.
    * "Wrapper" views (responsible for page setup and embedding Orchestrators).
    * The Blade views directly associated with and rendered by Livewire components (including Orchestrators). [Laravel's Blade Views](https://laravel.com/docs/10.x/blade)
* **Controller (C):**
    * **Livewire Component as Controller:** Within LOP, the **PHP class of any Livewire component is considered a Controller** for its specific UI segment. It encapsulates logic to handle user input (actions, data binding), manage component state (public properties), interact with Models or Services, and determine how its corresponding Blade view is rendered.
    * **Orchestrator as a Primary Controller:** The "Orchestrator" is a specific, high-level Livewire component that acts as the primary controller for an entire complex page or feature.
    * **Traditional Laravel Controllers:** Standard controllers (e.g., in `app/Http/Controllers/`) still play a role for tasks outside the direct UI management of a Livewire component. These include:
        * Defining API endpoints.
        * Serving pages or sections of the application not managed by Livewire.
        * Handling complex backend processes or actions that are better suited for a dedicated controller method (e.g., after being initiated by a Livewire component).
    * [Laravel's Controller](https://laravel.com/docs/10.x/controllers) and [Livewire's Components](https://livewire.laravel.com/docs/components)
* **Orchestrator (O):** A **Livewire component designated as the primary controller** for a significant feature or a complex page. It manages the overall state, user interactions, and presentation logic for that scope, often coordinating data from multiple sources or managing child Livewire components.
* **Wrapper (W):** A simple Blade view, typically returned directly by a route. Its main role is to define the overall page layout (e.g., using `<x-app-layout>`) and embed the primary "Orchestrator" Livewire component for that page or section.


## The Wrapper: Setting the Stage

The Wrapper is the entry point for a page view defined in your `web.php` routes. Its primary responsibilities are:
1.  Establishing the overall HTML page structure (e.g., `<html>`, `<head>`, `<body>`).
2.  Applying the correct application layout (e.g., main app layout, admin layout).
3.  Embedding the "Orchestrator" Livewire component that will manage the page's content and interactivity.

**File Structure:**
Wrappers are typically located in `resources/views/wrappers/`. Their subdirectory structure often mirrors the feature area they serve.
* Example: `resources/views/wrappers/admin/leagues/manage-leagues-wrapper.blade.php`

```php
<x-admin-layout> {{-- Or your specific app layout --}}
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('League Management') }}
        </h2>
        @include('layouts.admin-top-nav')
    </x-slot>

    <div id="pagetop">
        <div class="max-w-7xl mx-auto px-10 py-10 sm:px-6 lg:px-8">

        @can('manage league')
            {{-- The Orchestrator Livewire component is embedded here --}}
            <livewire:admin.leagues.manage-leagues-orchestrator />
        @endcan
    </div>
</x-admin-layout>
```


## The Orchestrator: The Conductor of Complex UIs
The Orchestrator is a Livewire component that acts as the central hub for a complex user interface or feature set. For example, a "League Management" page might involve displaying all leagues, allowing creation/editing of leagues, viewing participants, and managing schedules. An Orchestrator can manage all these aspects within a single, cohesive component.

### Key Responsibilities:

* Manages the state for the feature (e.g., current view, selected items, form data).
* Handles user interactions (button clicks, form submissions) through its public methods.
* Fetches and prepares data from Models or Services for its view.
* Conditionally renders different parts of its UI based on its state (e.g., showing a list view vs. an edit form).
* May dispatch Livewire events or interact with child Livewire components.
* May delegate specific backend operations to traditional Controllers or Action/Service classes.

### File Structure:
Orchestrator Livewire components consist of a PHP class and a Blade view:

* PHP Class: app/Livewire/FeatureArea/MyOrchestratorName.php
    * Example: app/Livewire/Admin/Leagues/ManageLeaguesOrchestrator.php
* Blade View: resources/views/livewire/feature-area/my-orchestrator-name.blade.php
    * Example: resources/views/livewire/admin/leagues/manage-leagues-orchestrator.blade.php

### Conceptual Orchestrator Logic (PHP):

```php
// app/Livewire/Admin/Leagues/ManageLeaguesOrchestrator.php
namespace App\Livewire\Admin\Leagues;

use Livewire\Component;
use App\Models\League;

class ManageLeaguesOrchestrator extends Component
{
    public string $currentSection = 'list'; // e.g., 'list', 'create', 'edit'
    public ?League $selectedLeague = null;
    // ... other properties for form data, etc.

    public function showCreateForm()
    {
        $this->currentSection = 'create';
        $this->selectedLeague = null; // Reset
    }

    public function editLeague(int $leagueId)
    {
        $this->selectedLeague = League::findOrFail($leagueId);
        $this->currentSection = 'edit';
    }

    // ... methods for save, update, delete, changing sections

    public function render()
    {
        return view('livewire.admin.leagues.manage-leagues-orchestrator', [
            'leagues' => ($this->currentSection === 'list') ? League::all() : collect(),
        ]);
    }
}
```

### Conceptual Orchestrator View (Blade):

```php
{{-- resources/views/livewire/admin/leagues/manage-leagues-orchestrator.blade.php --}}
<div>
    <div class="mb-4">
        <button wire:click="showCreateForm" class="...">Add New League</button>
        {{-- Other top-level actions or navigation within the orchestrator --}}
    </div>

    @if($currentSection === 'list')
        {{-- Display table of leagues --}}
        {{-- @foreach($leagues as $league) ... <button wire:click="editLeague({{ $league->id }})">Edit</button> ... @endforeach --}}
    @elseif($currentSection === 'create')
        {{-- Display form for creating a new league --}}
        {{-- <livewire:admin.leagues.create-form /> (Example of using a child component) --}}
    @elseif($currentSection === 'edit' && $selectedLeague)
        {{-- Display form for editing $selectedLeague --}}
        {{-- <livewire:admin.leagues.edit-form :league="$selectedLeague" /> --}}
    @endif
</div>
```

## Benefits of LOP

* Organized Complexity: Provides a clear structure for complex pages with multiple states and interactions.
* Leverages Livewire: Maximizes Livewire's capabilities for dynamic, stateful UIs.
* Separation of Concerns:
    * Wrapper: Handles overall page layout and bootstrapping.
    * Orchestrator: Manages the core logic and presentation of a specific feature.
    * Models/Services: Contain business logic.
* Developer Ergonomics: Offers a predictable pattern for team members to follow.