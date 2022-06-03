---
title: "Tips and tricks"
description: "A variety of tips and tricks covering many of the applications I use."
slug: ""
image: ""
keywords: ""
date: 2020-04-09T08:17:35-05:00
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 60
---

## Hugo

### Shortcode in a code block

In order to document shortcode usage, it must be placed in a code block. Generally, hugo still parses it as a shortcode but this can be overridden using a comment block around the short code. For example:

{{% alert title="Note" %}}This is an alert.{{% /alert %}}

```
{{%/* alert title="Note" */%}}This is the documentation for the alert shortcode.{{%/* /alert */%}}

{{%/*/* alert title="Note" */*/%}}Entered into code block with comments.{{%/*/* /alert */*/%}}
```


## SSH

### Remove SSH know_hosts

*for Chrome app Secure Shell*

When working in a closed network, there are times when the host identification will change. When that happens, attempts to connect using the Secure Shell app will fail with the following message:

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED! @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
d6:be:12:7e:22:23:c3:e1:56:30:d6:cd:65:b7:ab:42.
Please contact your system administrator.
Add correct host key in /.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /.ssh/known_hosts:7
ECDSA host key for xxxxxxxxxxxxx.yyy.au has changed and you have requested strict checking.
Host key verification failed.
NaCl plugin exited with status code 255.
(R)econnect, (C)hoose another connection, or E(x)it?
```

This can only be fixed by removing the offending key. Make note of the number shown at the end of the line, Offending ECDSA key in /.ssh/known_hosts:7. That number depends on your system and is the index of the offending key.

* Open the JavaScript console, `CTRL + Shift + J`
* Enter `term_.command.removeKnownHostByIndex(INDEX);` into the console. Replace INDEX by the index of your offending key.
* Alternatively, you may clear all host keys with `term_.command.removeAllKnownHosts();`

*from [gaggl](https://www.gaggl.com/2015/07/chromeos-removing-ssh-known_hosts-from-chromebook/)*


## Git

### Update a submodule

To update a submodule to the latest commit available from the remote,

* Change to the submodule directory. `cd submod_dr`.
* Checkout master branch, `git checkout master`
* Pull, `git pull`.
* Done, so return to project root.
* Commit the update, `git commit -am "Pulled a submodule update`.

*There might be [other options](https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin) but this usually works for me*

