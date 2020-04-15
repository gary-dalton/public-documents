---
title: "Document system"
date: 2020-04-08T09:46:25-05:00
weight: 2
description: >
  My documentation system
draft: false
---

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
 * Host the website on Github.

{{% alert title="Note" %}}It is always a good idea to follow a [documentation style guide](https://developers.google.com/style){{% /alert %}}

## Create markdown documents

Learn more about [markdown](https://www.markdownguide.org/).

Markdown may be edited in any plain text editor. It is really nothing more than plain text with some special syntax for markup. Most markdown documents have the .md extension. I use [VS Code](https://code.visualstudio.com/) for markdown editing. This is the same editor I use for writing code. It is cross-platform, fast, extensible, and easy to install.

* Download and install VS Code.
  * For Ubuntu,  follow the [Debian and Ubuntu based distributions](https://code.visualstudio.com/docs/setup/linux) instructions.
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

The theme we choose to use, *Docsy*, requires the extended version of Hugo.

* For Ubuntu, `sudo apt-get install hugo-extended`
* For Windows, I use the [Chocolatey](https://chocolatey.org/) package manager.
  * Install Chocolatey following the instructions at [Installing Chocolatey](https://chocolatey.org/install)
  * Install Hugo with `choco install hugo-extended -confirm`.
* Verify your installation with `hugo version`.

Now read up on how to use Hugo. Don't read in too much detail but I especially recommend reading about the Directory Structure, Content Organization, Configuring Hugo and a little bit on Templating and Blocks.

## Docsy template

Learn more about [Docsy](https://www.docsy.dev/).

One of the reasons to use Hugo is it is very easy to change the complete look and feel of a website using templates. The Docsy template is designed for websites that are mostly devoted to documentation.

### Install Docsy

This follows the [Docsy readme](https://github.com/google/docsy#docsy)

* We have already installed hugo-extended.
* Nodejs is required. Check if it is installed using, `node -v`. If it is installed, no need to install it again.
* For Windows, [download and install nodejs](https://nodejs.org/en/). This installs both Nodejs and npm.
* For Ubuntu,
  * `sudo apt install nodejs`
  * `sudo apt install npm`
* Install PostCss,
  * `sudo npm install -D --save autoprefixer`
  * `sudo npm install -D --save postcss-cli`

I chose to start my documentation system based on the [Docsy Example Project](https://www.docsy.dev/docs/getting-started/#option-1-clone-the-docsy-example-site). If you don't already have Git installed, [install it](/docs/development-environment/git/) now.

* From the command line, navigate to the path into which you wish to clone the Docsy example.
* `git clone https://github.com/google/docsy-example.git`
* `cd docsy-example`
* `git submodule update --init --recursive`
* `npm install`

## Start using your system

Read the documentation from both [Hugo](https://gohugo.io/documentation/) and [Docsy](https://www.docsy.dev/docs/) to get an understanding of how to organize and create new pages. Sometimes, it is useful to review the [Docsy example](https://example.docsy.dev/).

Archetype files are those which control the content of newly added pages. Create a new folder named archetypes, then create a new page named default.md within that folder. Add the following and save the file.

```go
---
title: "{{ replace .TranslationBaseName "-" " " | title }}"
description: ""
slug: ""
image: ""
keywords: ""
date: {{ .Date }}
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: true
weight: 100
---

{{%/* pageinfo */%}}
This is a placeholder page.
{{%/* /pageinfo */%}}
```

Note the metatags *draft* and *weight*. Draft controls whether or not the page is included in your website. Once you have added content to the page, make sure to change draft to false. Weight controls where in the hierarchial navigation system the page appears.

### Add a new page

All new pages you add using Hugo are added into the content folder. Think about the overall structure of your documents because this hierarchy is carried over into the website. The page you are viewing was added using the command,
```go
hugo new "docs/Document system/_index.md"
```

## Git and hosting

Not yet performed.
