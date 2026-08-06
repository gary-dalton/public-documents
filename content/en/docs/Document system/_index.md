---
title: "Document system"
date: 2020-04-08T09:46:25-05:00
weight: 10
description: >
  How this site is built and maintained: markdown drafted in a dev container,
  built by Hugo with the vendored Docsy theme, versioned with git on GitHub,
  and deployed by Render.
tags: ["hugo", "docsy", "documentation"]
categories: ["documentation"]
draft: false
---

{{% pageinfo %}}
This page describes the system as it runs today: dev container, vendored theme, Render builds. The manual procedures from earlier stages of the system are preserved in the [2023 revision of this page](https://github.com/gary-dalton/public-documents/blob/794746085746a076e4075b0674a2fdf53b1aa540/content/en/docs/Document%20system/_index.md) on GitHub.
{{% /pageinfo %}}

## Overview

The first step in starting a document system is to evaluate and determine which system to use. Based on experience, I decided that my system needed:
 * Documents written in markdown for simplicity, universality, and versioning.
 * Documents organized in a tree fashion with options for categories and tagging.
 * Standardized presentation formatting.
 * Advanced formatting and presentation options.
 * Easily searchable.
 * Available from anywhere.

In other words, I wanted a system that converted markdown documents to an organized and hyperlinked website.

The solution I and many others have chosen is:
 * Use your favorite editor to create plain text markdown documents.
 * Use Hugo with the Docsy theme to convert the markdown documents to a website.
 * Use git for versioning and transfer of files.
 * Host the `master` branch on GitHub. Render builds and serves the website from it.

{{% alert title="Note" %}}It is always a good idea to follow a [documentation style guide](https://developers.google.com/style){{% /alert %}}

## Create markdown documents

Learn more about [markdown](https://www.markdownguide.org/).

Markdown may be edited in any plain text editor. It is really nothing more than plain text with some special syntax for markup. Most markdown documents have the .md extension. I use [VS Code](https://code.visualstudio.com/) for markdown editing. This is the same editor I use for writing code. It is cross-platform, fast, extensible, and easy to install.

* Download and install VS Code.
  * For Ubuntu, follow the [Debian and Ubuntu based distributions](https://code.visualstudio.com/docs/setup/linux) instructions.
  * For Windows, follow the [Windows](https://code.visualstudio.com/docs/setup/windows) instructions.
* Open VS Code and familiarize yourself with the interface.
* Create a new markdown document with **File > New File**.
* Save your file with a .md extension using **File > Save As...**.
* Add your markdown and save when done.

## Hugo

Learn more about [Hugo](https://gohugo.io/).

Hugo is a static site generator. Basically, it takes file structure, markdown documents, and templates to create a static website which is then viewable in any browser.

There is a small learning curve to using Hugo, although much of that is conceptual. After all, a document system that matches the requirements is not a simple thing. In practice, Hugo is relatively easy to use.

### Install Hugo extended

Since 2026, I work in a [dev container](https://github.com/gary-dalton/public-documents/tree/master/.devcontainer) that provides Hugo extended and the Node/PostCSS toolchain. The container definition in the repository is the authoritative record of the environment. The manual installation procedures this page used to document are in the revision linked at the top of the page.

The theme we choose to use, *Docsy*, requires the extended version of Hugo. The dev container provides it, so there is no installation step: opening the repository in the container is the setup. Verify with `hugo version`; the output must include the word `extended`.

Now read up on how to use Hugo. Don't read in too much detail but I especially recommend reading about the Directory Structure, Content Organization, Configuring Hugo, and a little bit on Templating and Blocks.

## Docsy template

Learn more about [Docsy](https://www.docsy.dev/).

One of the reasons to use Hugo is it is very easy to change the complete look and feel of a website using templates. The Docsy template is designed for websites that are mostly devoted to documentation.

### Install Docsy

The install history is three stages. I originally installed the theme as a git submodule, following the [Docsy Example Project](https://www.docsy.dev/docs/getting-started/#option-1-clone-the-docsy-example-site). I then migrated it to a [Hugo Module](https://www.docsy.dev/docs/updating/convert-site-to-module/). Those procedures are in the page history linked above.

Today there is nothing to install. Docsy is a Hugo Module pinned in `go.mod` and vendored: `hugo mod vendor` copies the theme into the committed `_vendor/` directory, so builds need no network access and no Go toolchain, and the theme version cannot drift. The dev container provides the Node and PostCSS toolchain the theme's asset pipeline requires. Preview the site with:

```bash
hugo server -D --watch --poll 700ms --bind 0.0.0.0 --liveReloadPort=1313
```

Upgrades are deliberate. The steps:

1. Read the [Docsy release notes](https://github.com/google/docsy/releases) for the target version. Check two things: whether it requires a newer Hugo than the version pinned in `render-build.sh` (see [Hosting](/docs/document-system/hosting/)), and whether it renames any config parameters this site sets in `hugo.toml`.
2. If a newer Hugo is required, 
    * follow the version-bump procedure on the [Hosting](/docs/document-system/hosting/) page before continuing
    * rebuild the dev container to get a current Hugo
    * then edit the `VERSION=` line in `render-build.sh` to match the output of `hugo version` in the rebuilt container. The local preview and the Render build then use the same Hugo.
3. Fetch the new theme version:
   ```bash
   hugo mod get github.com/google/docsy@v<version>
   ```
   Note the `v` prefix on the version tag. Always name an explicit version; `hugo mod get -u` fetches whatever is latest, which turns a deliberate upgrade into an accidental one.
4. Re-vendor. This regenerates `_vendor/` from the module cache:
   ```bash
   hugo mod vendor
   ```
5. Delete the theme's own `package.json` manifests, which otherwise cause Dependabot (GitHub's dependency alerting service) to raise false alerts for Bootstrap's and Docsy's dev dependencies:
   ```bash
   find _vendor -name package.json -delete
   ```
6. Re-diff every template override in `layouts/` against its new upstream counterpart under `_vendor/github.com/google/docsy/layouts/`. An override copies theme markup, so it silently misses upstream changes until it is reconciled by hand. The [Theme Overrides](/docs/document-system/theme-overrides/) page catalogs every override and what it does. Diff each pair, for example:
   ```bash
   diff layouts/partials/taxonomy_terms_cloud.html \
     _vendor/github.com/google/docsy/layouts/_partials/taxonomy_terms_cloud.html
   ```
   The differences should be exactly the local customization and nothing else. Anything else is an upstream change to port into the override.
7. Test locally with `hugo server -D`. Test the pages the various overrides touch: a blog list and single page, a page with a table of contents, the tag cloud in the sidebar, and the 404 page. Watch the console for new deprecation warnings.
8. Commit `go.mod`, `go.sum`, `_vendor/`, and any reconciled overrides together, so one commit records the whole upgrade.

## Start using your system

Read the documentation from both [Hugo](https://gohugo.io/documentation/) and [Docsy](https://www.docsy.dev/docs/) to get an understanding of how to organize and create new pages. Sometimes, it is useful to review the [Docsy example](https://example.docsy.dev/).

The archetype, `archetypes/default.md`, is the template for a new page's front matter. The current archetype:

```go
---
title: "{{ replace .TranslationBaseName "-" " " | title }}"
linkTitle: "{{ replace .TranslationBaseName "-" " " | title }}"
author: "Gary Dalton"
description: ""
resources:
- src: ""
  title: ""
  params:
    byline: "Photo: Gary Dalton / CC-BY-CA"
slug: ""
keywords: ""
tags: []
categories: []
date: {{ .Date }}
aliases: ""
expiryDate: ""
layout: ""
notoc: false
draft: true
weight: 100
---

{{%/* pageinfo */%}}
This is a placeholder page.
{{%/* /pageinfo */%}}
```

The fields:

* `title` and `linkTitle`: the full page title, and the shorter label used in navigation.
* `author`: the page byline.
* `description`: the meta description, also used as a lead line by some layouts.
* `resources`: attaches page-bundle images, with a byline credit. This is how a page carries images: the `imgproc` shortcode renders them in content, and an image resource whose filename contains `featured` becomes the page's thumbnail in blog listings.
* `slug`: overrides the URL segment derived from the filename.
* `keywords`: metadata for search engines.
* `tags` and `categories`: the taxonomies. Every page gets both: categories are the broad content-type buckets, tags are specific topics.
* `date`: the publication date. Blog permalinks are built from it.
* `aliases`: old URLs that redirect to this page after it moves.
* `expiryDate`: unpublishes the page after that date.
* `layout`: overrides the template choice; rarely used.
* `draft`: controls whether the page is included in the built website. Once a page has content, change draft to false to publish it.
* `weight`: controls where the page appears in the hierarchical navigation. I assign weights in decades (10, 20, 30) so that a later page can slot between two existing ones with a 15 or a 25, without renumbering anything.

The archetype also carries `notoc: false`. Setting it to true suppresses the Contents box on that page; the mechanics are on the [Theme Overrides](/docs/document-system/theme-overrides/) page. Three former archetype fields, `image`, `include_toc`, and `show_comments`, are not read by any current template. They linger in older pages' front matter with no effect; page images work through `resources` instead.

Section `_index` files use a few structural fields beyond the archetype: `menu` puts a top-level section in the navbar, `cascade` pushes settings such as `type: docs` down to every child page, and `type` selects the layout family directly.

### Add a new page

All new pages go into the content folder. Think about the overall structure of your documents because this hierarchy is carried over into the website. I do not use `hugo new`. Instead, I just create a new page as a new file in the editor with the archetype's front matter copied in, or I tell my AI assistant to draft a new page at the specified content hierarchy. The archetype is therefore the reference for what front matter a page carries, whether or not Hugo generates the file.

## Git, hosting, and publishing

These parts of the system grew enough to earn their own pages:

* [Git Workflow](/docs/document-system/git-workflow/) covers the repository, the edit-preview-commit-push cycle, and what never gets committed.
* [Hosting](/docs/document-system/hosting/) covers the Render static site and the build script that pins Hugo and repairs the shallow checkout.
* [Research and Publishing Workflow](/docs/document-system/publishing-workflow/) covers the two paths to publication: drafting directly on this site, and the private research repository used for complex or in-depth work.
* [Use of AI](/docs/document-system/ai-use/) covers where AI sits in drafting and in git, and the rules that keep authorship and accuracy with the author.
* [Theme Overrides](/docs/document-system/theme-overrides/) catalogs the site's Docsy customizations: template shadows, custom shortcodes, and SCSS project files.
