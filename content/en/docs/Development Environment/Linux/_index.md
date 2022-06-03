---
title: "Linux"
description: "The Ubuntu Linux system for machine learning and other development purposes."
slug: ""
image: ""
keywords: ""
categories: 
    - ""
    - ""
date: 2020-04-08T09:59:15-05:00
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 40
---

## Overview

This computer is a general use computer, not a server. The basic install may be either the full Ubuntu desktop or my preference which is Lubuntu. Lubuntu is a lightweight version of Ubuntu, with a toned down graphical interface and no default installation of certain desktop software like an office suite.

I do not use the Ubuntu system as my primary computer but specifically for development and running of machine learning tasks. The machine learning tasks often take a lot of processing power and time, so expect the machine to be unavailable during those task runs.

My main office computer is a Windows based machine. I often use Ubuntu in a headless configuration, so connectivity is important.

{{< alert color="warning" >}}During installation of Ubuntu, make certain you are able to connect using wifi. Wifi often uses proprietary drivers that must be installed while connected to the internet.{{< /alert >}}


## Git

[Git](https://git-scm.com/), the version control system. Use It!



* Install Git, `sudo apt install git-all`.
* Check the version, `git --version`.
* Configure git,
```
git config --global user.name "Your Name"
git config --global user.email "youremail@domain.com"
```

For help on [using git](https://git-scm.com/doc), see my [Tips and tricks](/docs/tips-and-tricks/#git)
