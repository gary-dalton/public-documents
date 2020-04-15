---
title: "Windows"
description: "The Windows 10 desktop. My main computer with many linkages to the Linux server."
slug: ""
image: ""
keywords: ""
date: 2020-04-08T09:59:29-05:00
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 20
---

## Overview

This computer has been up and running for some time. I intend on documenting new applications that I add for development but also to back-document features and applications I use regularly.

## Connecting to a remote server

### PuTTY for remote connection

[PuTTy](https://www.chiark.greenend.org.uk/~sgtatham/putty/) has been around for a long time and still works wonderfully and is regularly maintained. PuTTY is used by Windows machines to connect to OpenSSH servers.

Here, I will only document actions needed to connect to a new Linux development server.

#### Generate a key pair

Generating a key pair and securely connecting to a remote Linux machine.

1. Start **PuTTYgen**
2. Change the *Number of bits in a generated key* to 2048.
3. Click **Generate** to generate a new key pair.
4. Add a password to the *Key passphrase* and *Confirm passphrase*. If you choose to not have a password, then do not enter these here.
5. Save your public and private keys. The private key should not be shared but the public key may be freely shared.
6. On the target Linux computer,
    * `mkdir ~/.ssh`
    * `nano ~/.ssh/authorized_keys`.
7. Copy the public key from the Windows PuTTYgen box and paste it into the authorized_keys file on your target. Save the file.
8. Close PuTTYgen.
9. Open PuTTY.
10. Save a new session named *target* and put *ip_address* in the Host Name box.
11. From the configuration Category pane, select **Connection > SSH > Auth**.
12. Browse to select the private key you created earlier for authentication.
13. Save the session.
14. Test by clicking Open.
15. You should be required to enter in the username to log in with and also the password used to protect the key.

{{% alert color="warning" %}}**Do not lose your private keys. Once the next configuration steps are complete, your private key and password are required to login remotely.** You will still be able to login from the console or with a keyboard and monitor.{{% /alert %}}


### TigerVNC for remote desktop

TigerVNC is used to connect to a desktop on a remote Linux server.

#### Install TigerVNC and connect

Download a [vncviewer binary for Windows](https://github.com/TigerVNC/tigervnc/releases). The name of the file is likely *vncviewer-ver.exe*. Download the file to a location of your choice (I use C:\bin). Create a shortcut on the desktop and click to start the viewer.

{{< figure src="tigervnc.png" caption="TigerVNC viewer on Windows" >}}

See the above figure. In the *VNC server* box enter the ip address of the server to connect to follwed by *:1*, where 1 is the number of the desktop you started on the server. Click **Connect** and enter your password when requested.

#### Cannot connect?

If you are having trouble connecting, check the following:

* Make certain that Xtigervnc is listening on the 0.0.0.0:590x interface.
* Verify that you entered the correct ip address and port number into the vncviewer.
* Check your firewalls.
    * On Windows, temporarily turn off the firewall and try to connect again.
    * On Linux, `sudo ufw status` shows if the fire wall is active. If it is, temporarily disable it using `sudo ufw disable` and try to connect again.
    * If the problem is a firewall, correct the issue and move on. Firewalls are not yet part of this documentation.

### Connecting to JupyterHub

Simply point your browser to the ip address of your server and append the port being served. The default port for JupyterHub is 8000, my [JupyterHub](http://192.168.1.67:8000).

## Windows development environment

Most of these tools are already installed and working. Also, they are mostly simple and direct Windows installations. I will not be giving details on installation unless there is something unusual about the install.

### My Windows tools

* Anaconda 3
* Python
* RStudio
* Julia
* Atom
* Juno
* VS Code
* Android Studio
* IntelliJ
* Octave
* MatLab
* Git
* VirtualBox
* TexMaker

