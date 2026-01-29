---
title: "Python WSL2"
description: "This guide outlines the complete setup and workflow for running Python development on Windows using the Windows Subsystem for Linux (WSL). This approach allows for a robust, Linux-based development environment with full GUI support (WSLg) while keeping the Windows host clean"
slug: ""
image: ""
keywords: ""
date: 2026-01-07
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 50
---




---
# Python Development on Windows via WSL2 (Ubuntu)

This guide outlines the complete setup and workflow for running Python development on Windows using the Windows Subsystem for Linux (WSL). This approach allows for a robust, Linux-based development environment with full GUI support (WSLg) while keeping the Windows host clean.

## Part 1: Initial Setup (One-Time Only)

### 1. Install WSL and Ubuntu
If you have not installed WSL yet, open **Command Prompt** or **PowerShell** as Administrator and run:

```powershell
wsl --install -d Ubuntu

```

* **Restart:** You may need to restart your computer.
* **User Setup:** After restart, a terminal window will open asking you to create a Unix username and password. These are specific to this Ubuntu instance.

### 2. Configure Ubuntu Environment

Open your **Windows Terminal** and select **Ubuntu** from the dropdown. Run the following commands to update the system and install necessary tools for Python and GUI support.

**Update Package Lists:**

```bash
sudo apt update

```

**Install Essential Tools:**

* `x11-apps`: Required for testing GUI (includes `xeyes`).
* `python3-tk`: Required for Python visuals (Matplotlib/Tkinter) to render windows.
* `python3-pip`: The package installer for Python.
* `python3-venv`: Tool to create isolated virtual environments (crucial for modern Linux).

```bash
sudo apt install x11-apps python3-tk python3-pip python3-venv -y

```

### 3. Verify GUI Support

Test that Windows can display Linux apps:

```bash
xeyes

```

* *Success:* A pair of eyes appears on your desktop. Close the window to stop the terminal process (or press `Ctrl+C`).
* *Failure:* If you get an error, ensure you are on a recent version of Windows 10/11 with WSLg support.

---

## Part 2: Project Setup

Establish a specific directory for your coursework to keep it organized and isolated.

### 1. Create Project Directory

```bash
mkdir ~/projects
cd ~/projects

```

### 2. Create Virtual Environment

Modern Ubuntu (PEP 668) prevents global `pip` installs to protect system stability. You **must** use a virtual environment.

```bash
python3 -m venv venv

```

---

## Part 3: Day-to-Day Workflow

Follow this routine every time you start a coding session.

### 1. Open Terminal & Navigate

Open **Ubuntu** terminal and go to your folder:

```bash
cd ~/projects

```

### 2. Activate the Sandbox (CRITICAL)

Activate the virtual environment. You will see `(venv)` appear in your prompt.

```bash
source venv/bin/activate

```

### 3. Launch VS Code

Open VS Code connected to this specific folder in the Linux file system.

```bash
code .

```

* *Note:* Ensure the "WSL" extension is installed in VS Code.

### 4. Install Libraries (If needed)

With `(venv)` active, you can install course requirements safely:

```bash
pip install numpy matplotlib pandas

```

### 5. Run Code

Execute your Python scripts. GUI windows will popup automatically on Windows.

```bash
python3 filename.py

```

### 6. Ending the Session

To exit the virtual environment (optional, closing the window also works):

```bash
deactivate

```

---

## Part 4: VS Code Configuration (Pro-Tip)

Configure VS Code to recognize your virtual environment automatically.

1. Open a Python file inside your project in VS Code.
2. Look at the bottom-right status bar for the Python version (e.g., "3.12.3").
3. Click it to **Select Interpreter**.
4. Choose the entry marked **`('venv': venv)`** or recommended with a star.
5. **Result:** VS Code will now provide correct autocomplete, and new terminals opened inside VS Code (`Ctrl + ~`) will automatically activate the environment.

```

```