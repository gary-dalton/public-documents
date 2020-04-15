---
title: "Headless operation"
description: "Headless means connecting remotely to perform tasks. This does not use the monitor, keyboard, or mouse connected to the Ubuntu computer. It does require having the SSH service for remote command line and also a VNC server to access the GUI."
slug: ""
image: ""
keywords: ""
date: 2020-04-13T11:07:59-05:00
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 1
---

## SSH server



{{% alert %}}The install of OpenSSH mostly follows the [Ubuntu guide](https://help.ubuntu.com/lts/serverguide/openssh-server.html).{{% /alert %}}

* Install, `sudo apt install openssh-server`
* Copy original configuration, 
    * `sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original`
* Protect original configuration`sudo chmod a-w /etc/ssh/sshd_config.original`
* Edit the configuration file, `sudo nano /etc/ssh/sshd_config`
* Add the following to the configuration file while insuring that no other matching parameter is uncommented.

```md
PermitRootLogin no
PubkeyAuthentication yes
UsePAM yes
X11Forwarding yes
AllowUsers your-user-name
```

* Restart the service, ` sudo service sshd restart`

Make certain you are able to connect to the server remotely before adding public key authentication.

* Get the ip address, `ip address show`
* Connect using your favorite client to the ip address. (on Windows, I use PuTTy)

### Using public key authentication

{{% alert %}}More than you ever need to know about [SSH keys from archlinux](https://wiki.archlinux.org/index.php/SSH_keys).{{% /alert %}}

Since I am connecting from a Windows machine, see [Windows PuTTY](/docs/development-environment/windows/#putty). This covers generating the key pair and connecting to Linux from Windows.

Once you have verified that you are able to connect using public key authentication, you may disable password login on Linux. This is not required but greatly enhances security.

* Open the configuration file, `sudo nano /etc/ssh/sshd_config`.
* Add or edit the following lines to the file and save:
```
PasswordAuthentication no
UsePAM no
PubkeyAuthentication yes
```
* Reload the sshd configuration, `sudo service sshd reload`.
* Test the settings by logging in remotely. Try logging in both with and without the key file.

## VNC server

A VNC server allows remote login to either a virtual desktop or the actual desktop of the Linux machine. If you just want remote access to the GUI, connect to a virtual desktop. If you wish to see the actions performed remotely on the desktop, i.e., a connected monitor, connect to the actual desktop.

{{% alert %}}For complete details view the [archlinux TigerVNC guide](https://wiki.archlinux.org/index.php?title=TigerVNC).{{% /alert %}}

This install uses TigerVNC, which is an actively maintained fork of the venerable TightVNC.

### Connect to a virtual desktop

* Install TigerVNC, `sudo apt install tigervnc-standalone-server tigervnc-viewer`.
* As a standard user, start a virtual desktop, `vncserver -localhost no :1`. Without *-localhost no*, TigerVNC wil listen on localhost (127.0.0.0) only.
* The first time you run this command, you will be asked to set a password. For basic security, please do set a password.
* Upon success, you should see something like:
```
Cleaning stale pidfile '/home/user/.vnc/hostname:1.pid'!

New 'hostname:1 (user)' desktop at :1 on machine hostname

Starting applications specified in /home/user/.vnc/Xvnc-session
Log file is /home/user/.vnc/hostname:1.log

Use xtigervncviewer -SecurityTypes VncAuth,TLSVnc -passwd /home/user/.vnc/passwd hostname:1 to connect to the VNC server.
```
* Verify it is listening for connections, `sudo netstat -tpln`.
* The result of this command should be similar to the below. Specifically, note that Xtigervnc is listening on *0.0.0.0:5901* and *:::5901*.

```
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      604/systemd-resolve
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      831/sshd
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      694/cupsd
tcp        0      0 0.0.0.0:5901            0.0.0.0:*               LISTEN      1345/Xtigervnc
tcp6       0      0 :::22                   :::*                    LISTEN      831/sshd
tcp6       0      0 ::1:631                 :::*                    LISTEN      694/cupsd
tcp6       0      0 :::5901                 :::*                    LISTEN      1345/Xtigervnc

```

* Go to your client machine and verify the ability to connect.
* If you are having firewall problems see the [Ubuntu firewall guide](https://help.ubuntu.com/lts/serverguide/firewall.html).
* Kill the server, `vncserver -kill :1`.
* Edit the configuration, `sudo nano  /etc/vnc.conf`, by changing the parameters to:

```
$localhost = "no";
$SecurityTypes = "VncAuth,TLSVnc";
```

Now, anytime you wish to connect to a virtual desktop,
* Use SSH to login.
* As a standard user, start a virtual desktop, `vncserver :1`.
* Connect with your client.
* When done, kill the server with `vncserver -kill :1`.


### Connect to the actual desktop

I recommend performing this installation after successfully connecting to a virtual desktop.

{{< alert color="warning" >}}You must first physically login to the actual desktop and remain logged in.{{< /alert >}}

* Install TigerVNC's scraping server, `sudo apt-get install tigervnc-scraping-server`.
* From a SSH session, start the scraping server,
    * `x0vncserver -PasswordFile ~/.vnc/passwd -display :0`.
* Go to your client system and connect to *:0*.
* Connect with your client.
* When done, kill the server with **CTRL + C**.

*from [HowToForge](https://www.howtoforge.com/tutorial/how-to-start-a-vnc-server-for-the-actual-display-scraping-with-tigervnc/)*