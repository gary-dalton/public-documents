---
title: "Theme Overrides"
linkTitle: "Theme Overrides"
author: "Gary Dalton"
description: "The site's customizations of the Docsy theme: template shadows, custom shortcodes, and SCSS project files, and what each one does."
slug: ""
keywords: "hugo, docsy, theme, templates, overrides, scss"
tags: ["hugo", "docsy", "theme"]
categories: ["documentation"]
date: 2026-08-06
expiryDate: ""
layout: ""
notoc: false
draft: false
weight: 50
---

## The principle

The vendored theme in `_vendor/` is never edited. Hugo resolves templates by looking in the site's own `layouts/` before the theme's, so a file at the same relative path shadows its theme counterpart. Customization happens by shadowing; the vendored copy stays pristine, and `hugo mod vendor` can regenerate it at any time without losing anything.

The cost of a shadow is that it copies theme markup at a point in time. When the theme upgrades, the shadow silently keeps the old markup until it is reconciled by hand, which is why the [upgrade steps](/docs/document-system/#install-docsy) include a re-diff of every override.

## Reconciling an override after an upgrade

An override starts as a copy of the upstream file plus one deliberate change. On the day it is created, diffing it against upstream shows exactly that change and nothing else. That expected diff is the override's signature.

The tag cloud override's signature, as it stands today:

```bash
diff -u _vendor/github.com/google/docsy/layouts/_partials/taxonomy_terms_cloud.html \
  layouts/partials/taxonomy_terms_cloud.html
```

```diff
@@ -1,16 +1,31 @@
+{{/* Shadows Docsy's taxonomy_terms_cloud.html to hide low-count tags.
+     For the "tags" taxonomy, terms with fewer pages than
+     params.taxonomy.tagCloudMinCount (default 1 = show all) are omitted
+     from the cloud. Term pages still exist; this only trims the display.
+     Other taxonomies (categories) are never filtered. */ -}}
 {{ $context := .context -}}
 {{ $taxo := .taxo -}}
 {{ $title := .title -}}
+{{ $min := 1 -}}
+{{ if eq (lower $taxo) "tags" -}}
+  {{ $min = $context.Site.Params.taxonomy.tagCloudMinCount | default 1 -}}
+{{ end -}}
 {{ if isset $context.Site.Taxonomies (lower $taxo) -}}
   {{ $taxonomy := index $context.Site.Taxonomies (lower $taxo) -}}
-  {{ if (gt (len $taxonomy) 0) -}}
+  {{ $terms := slice -}}
+  {{ range $taxonomy -}}
+    {{ if ge .Count $min -}}
+      {{ $terms = $terms | append (dict "page" .Page "count" .Count) -}}
+    {{ end -}}
+  {{ end -}}
+  {{ if (gt (len $terms) 0) -}}
     <div class="taxonomy taxonomy-terms-cloud taxo-{{ urlize $taxo }}">
       {{ with $title -}}
         <h5 class="taxonomy-title">{{ . }}</h5>
       {{ end -}}
       <ul class="taxonomy-terms">
-        {{ range $taxonomy -}}
-          <li><a class="taxonomy-term" href="{{ .Page.Permalink }}" data-taxonomy-term="{{ urlize .Page.Title }}"><span class="taxonomy-label">{{ .Page.Title }}</span><span class="taxonomy-count">{{ .Count }}</span></a></li>
+        {{ range $terms -}}
+          <li><a class="taxonomy-term" href="{{ .page.Permalink }}" data-taxonomy-term="{{ urlize .page.Title }}"><span class="taxonomy-label">{{ .page.Title }}</span><span class="taxonomy-count">{{ .count }}</span></a></li>
         {{ end -}}
       </ul>
     </div>
```

Every `+` and `-` line above is the customization: the explanatory comment, the minimum-count logic, the filtered term collection, and the render loop reading from it. If a future diff shows anything beyond these lines, that remainder is an upstream change to port.

The example above is itself a copy. When the override changes, regenerate it with the same command.

After a theme upgrade, diff the pair again and subtract the signature from what you see:

1. Nothing left over: upstream did not touch the file. Done.
2. Anything left over: upstream changed since the copy was made, and the override is missing those changes. Rebuild it: start from the new upstream file, reapply the local customization on top, and save that as the override. The diff is then clean again, showing the signature and nothing else.

Skipping step 2 does not break the build. Hugo uses the local file and ignores upstream entirely, so the site keeps working on the old markup. The cost is quieter: missed fixes accumulate until a structural upstream change finally breaks the stale copy outright.

## Template overrides

* `layouts/404.html` (upstream `404.html`): replaces the theme's not-found page with a short custom one that points back to the home page.
* `layouts/blog/list.html` (upstream `blog/list.html`): reshapes blog section listings: the section's own text renders as an intro block, and the post list gathers every post in the section and groups it by year.
* `layouts/blog/single.html` (upstream `blog/single.html`): reshapes individual blog posts: a compact title with the description as a lead line, an author, date, and updated byline, and a table of contents that renders first on small screens and as a sidebar on desktop.
* `layouts/partials/toc.html` (upstream `_partials/toc.html`): decides whether a page shows the "Contents" box. Three conditions determine it, in order:
   1. The page's layout family must have a TOC column at all: `docs`, `blog`, and `swagger` base templates call this partial; other layouts never ask.
   2. The page must not set `notoc: true` in front matter. This is the per-page off switch, and the only front matter field with any effect on the TOC.
   3. The generated table of contents must be at least 150 characters of HTML, a rough proxy for three or more headings. Trivial TOCs are suppressed rather than shown as a one-line box.

   The theme's base templates call the partial to fill the right sidebar on desktop; the blog single-page override calls it a second time in a mobile-only block so the contents appear above the post on small screens.
* `layouts/partials/taxonomy_terms_cloud.html` (upstream `_partials/taxonomy_terms_cloud.html`): hides tags with fewer pages than `params.taxonomy.tagCloudMinCount` from the sidebar tag cloud. Term pages still exist for every tag; only the cloud display is trimmed.

Note that upstream keeps partials under `_partials/` while the local shadows live in `partials/`. Hugo treats them as the same path.

## Custom shortcodes

The files in `layouts/shortcodes/` are the site's own, with no upstream counterpart.

* `last-updated`: prints a "Last updated" line from a page's `lastmod` front matter or, failing that, its git date.
* `lastmod-debug`: prints the raw and formatted last-modified values. A debugging aid for the git-dates pipeline.
* `feature-row`: a wrapper used by the landing pages, currently an empty template.

There is nothing to diff on upgrade, but there is one check: a new Docsy version could introduce a shortcode with the same name as a local one, which the local file would silently shadow.

## SCSS project files

Docsy provides two hook files that the site supplies under `assets/scss/`:

* `_variables_project.scss`: overrides theme SCSS variables (colors, fonts) before the theme's own SCSS compiles.
* `_styles_project.scss`: adds rules after the theme's styles. The navbar-logo `currentColor` rule here exists because Docsy 0.14 made the navbar background theme-aware while the site logo SVG is hard-coded white; the rule keeps the logo visible on light backgrounds. Keep it.

These are hooks by design, not copies of theme markup, so they survive upgrades without re-diffing. The check they need instead: a major theme version can rename the variables they set.
