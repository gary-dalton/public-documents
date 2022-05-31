---
title: "Data science platform"
description: "How to set up my data science platform. This includes Anaconda, Python, R, and Julia. All of these are runnable from the desktop, from a headless connection, and from the browser via JupyterHub."
slug: ""
image: ""
keywords: ""
date: 2020-04-13T11:08:30-05:00
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 20
---

## Anaconda

Anaconda is a data science platform that supports Python and R. It comes with many packages that are needed to perform good data science.

### Multi-user installation

Note the differences below, but this mostly follows [Anaconda's Installing on Linux for multiple users] (https://docs.anaconda.com/anaconda/install/multi-user/#multi-user-anaconda-installation-on-linux).

* Login as root, `sudo -i`.
* Follow instructions but change the install directory to */opt/anaconda3*.
* Create a new groups, `addgroup conda-grp`.
* Set the *conda-grp* as owner of the anaconda directory, `chgrp -R conda-grp /opt/anaconda3`.
* Change read/write permsissions on the directory, `chmod 770 -R /opt/anaconda3`.
* Add users to the group, `usermod -a -G conda-grp youruser`.
* Logout root, `exit`.
* Exit your shell session `exit`.
* Start a new session.
* Connect your user to the base environment
```
source /opt/anaconda3/bin/activate
conda init
```
* Restart your session again.
* Upon login, you should note *(base)* appears by your prompt.
* Verify the installation, `conda list` which lists all of the installed packages.
* Test python is from Anaconda, `python`. This starts the python shell with a heading that indicates the version and the source as Anaconda.
* Quit the python shell, `exit()`.
* Update the conda package manager, `conda update conda`.
* Update all packages, `conda update --all`.

Your Anaconda installation is complete and has fully functioning python environment. Now view the [User guide](https://docs.anaconda.com/anaconda/user-guide/). If you are working in the gui, start [Anaconda Navigator](https://docs.anaconda.com/anaconda/navigator/), `anaconda-navigator`.

## Jupyter

[Jupyter](https://jupyter.org/) is a web-based interactive development environment for notebooks, code, and data. JupyterLab is the next-gen version of Jupyter Notebook. JupyterLab is great to run on a standalone computer but I wish my Linux system to serve multi-user sessions of JupyterLab. This is most efficiently done using JupyterHub.

### Install JupyterHub

This mostly follows the [JupyterHub guide](https://github.com/jupyterhub/jupyterhub#installation), instructions for using conda.

* Install JupyterHub, `conda install -c conda-forge jupyterhub`.
* Install Jupyter Notebook to run locally, `conda install notebook`.
* Install JupyterLab to run locally and on the hub, `conda install jupyterlab`.

Test the installation by launching JupyterHub and then connect to it via a browser in the server's GUI.

* Launch JupyterLab, `jupyterhub`.
* Open your browser and connect to *localhost:8000*.
* Enter your server login credentials.
* You are logged into a standard Jupyter Notebook.
* Check JupyterLab by navigating to */lab* instead of */tree*.
* When done, close the browser. Then stop JupyterHub with **CTRL + C**.

### Configuring JupyterHub

This configuration is based upon the [JupyterHub documentation](https://jupyterhub.readthedocs.io/en/latest/getting-started/config-basics.html).

* Create a default configuration, `jupyterhub --generate-config`.
* Edit the configuration file. `nano jupyterhub_config.py` by adding,
```
c.JupyterHub.bind_url = 'http://0.0.0.0:8000'
c.JupyterHub.concurrent_spawn_limit = 20
c.JupyterHub.port = 8000
c.JupyterHub.authenticator_class = 'jupyterhub.auth.PAMAuthenticator'
```
* Move the configuration, `mv jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py`.

### JupyterHub as a service

*from [Run jupyterhub as a system service](https://github.com/jupyterhub/jupyterhub/wiki/Run-jupyterhub-as-a-system-service)*

* Create and edit the configuration file, 
    * `sudo nano /etc/systemd/system/jupyterhub.service`.
* Assuming Anaconda 3 was installed multi-user into */opt/anaconda3*. If you're not sure, you may check location with, `which jupyterhub`.  And assuming that the jupyterhub configuration file is */etc/jupyterhub/jupyterhub_config.py*. Add the following to the configuration:
```
[Unit]
Description=Jupyterhub
After=syslog.target network.target

[Service]
User=root
Environment="PATH=/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/anaconda3/bin"
ExecStart=/opt/anaconda3/bin/jupyterhub -f /etc/jupyterhub/jupyterhub_config.py

[Install]
WantedBy=multi-user.target
```

* Reload daemon, `sudo systemctl daemon-reload`.
* The availbale commands for the service are *start | stop | status*.
* Start the jupyterhub service, ` sudo systemctl start jupyterhub`.
* Check the status, `sudo systemctl status jupyterhub`.
* Verify by connecting with a browser.
* Stop the service, `sudo systemclt stop jupyterhub`.
* Enable the service to start upon boot, `sudo systemctl enable jupyterhub`.


## R language

First, we are going to install RStudio. This will be used for running beta and production code. Next, we will install and R environment in Anaconda for use with Jupyter.

### RStudio Installation

Install the desktop application RStudio along with the proper R binaries.

* Install prerequisites, `sudo apt install gdebi-core r-base`.
    * If you get a message about a broken install, try `sudo apt --fix-broken install` and try again.
* [Download RStudio] (https://rstudio.com/products/rstudio/download/).
* Run the install package, 
    * `sudo dpkg -i ~/Downloads/rstudio-1.2.5033-amd64.deb`.
* Test the installation by running RStudio from the GUI desktop.

Locate the R binary and make a note of it for future use.
 * `which R`
 * Mine is located at */usr/bin/R*.
 * Determine the version of R.
    * From the command line, ` R --version| grep -Eo 'R version [0-9.]+ \([0-9]{4}-[0-9]{2}-[0-9]{2}\)';`.
    * From RStudio, `R.version.string`.


### R environment in Anaconda

Here we install an R environment for easy use in JupyterHub. This will be managed separately from the RStudio we previously installed.

* In the base environment, run ` conda install nb_conda_kernels`. This allows Jupyter launched from base to access kernels from other environments. See [nb_conda_kernels](https://github.com/Anaconda-Platform/nb_conda_kernels#nb_conda_kernels).
* Create the R environment, `conda create -n r-env -c r r-essentials r-base r-irkernel`.
* Activate r-env, `conda activate r-env`. Then deactivate, `conda deactivate`.
* Test availability of r-env in JupyterHub. You might have to restart JupyterHub.


### Verify which R is being used

Previously, we determined that R resided at */usr/bin/R*. Now verify that the R being used from your base environment and by RStudio is the same as installed by RStudio.

* Verify that the location used by base matches previous, `which R`.
* Verify that location used by RStudio matches previous,
    * Open RStudio, click ther *Terminal* tab to get console.
    * `echo $RSTUDIO_WHICH_R`.
    * If needed, set it, `export RSTUDIO_WHICH_R=/usr/bin/R`.
    * Reopen RStudio to verify functioning.
    * Save the environment variable system-wide by creating or editing the file */etc/profile.d/myenvvars.sh*.
        * `sudo nano /etc/profile.d/myenvvars.sh`
        * Add the line *export RSTUDIO_WHICH_R=/usr/bin/R*.
    Reboot the computer to verify that changes are permanent.

*from [RStudio support](https://support.rstudio.com/hc/en-us/articles/200486138-Changing-R-versions-for-RStudio-desktop), [StackOverflow](https://stackoverflow.com/questions/28008765/how-to-get-my-r-version), and [Ubuntu Environment Variables](https://help.ubuntu.com/community/EnvironmentVariables)*



## Julia language

[Julia](https://julialang.org/) is a high level scientific programming language. I have found it very good at handling various maths and machine learning.


### Install Julia

This is a straightforward download, extract and point to binaries operation.

* Download the current release from [Julia](https://julialang.org/downloads/).
    * `cd Downloads`.
    * `wget "https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.0-linux-x86_64.tar.gz"`.
* Extract, `tar -xzvf julia-1.4.0-linux-x86_64.tar.gz`.
* Move the folder, `sudo mv julia-1.4.0 /opt/`.
* Create a symbolic link to the Julia binary,
    * `sudo ln -s /opt/julia-1.4.0/bin/julia /usr/local/bin/julia`.
* Test by entering, `julia`. The Julia REPL terminal should start.
* `exit()` when done.


### Upgrading Julia

Just follow the same process as for installing, just update the symbolic links.
* Move the old link,
    * `sudo mv /usr/local/bin/julia /usr/local/bin/julia-old-ver-number`.
* Create a new link, 
    * `sudo ln -s /opt/julia-new-ver-num/bin/julia /usr/local/bin/julia`.

If you remove the old installation directory, remember to also remove the old link. You will also still need to reinstall your packages on the new version.


### Install Juno

[Juno](https://junolab.org/) is an IDE for the Julia environment. It is built upon [Atom](https://atom.io/).

To install Atom using the Ubuntu package manager, follow their [Flight Manual](https://flight-manual.atom.io/getting-started/sections/installing-atom/#platform-linux).

Next, we log into the desktop, open the Atom editor and add [Juno](http://docs.junolab.org/latest/man/installation/).

* Atom is a GUI IDE, so open it from the navigation menu.
* Open settings with ** CTRL + ,**
* Open the *Install* pane.
* Search for the package *uber-juno*.
* Install *uber-juno*.

When this is complete, the Julia REPL shuold try to start. It might spend some time pre-compiling. Try a command, such as `cos(1)` to verify functioning. You will also notice a new menu bar entry for Juno.


### Add Julia to JupyterHub

Let's get Julia working with JupyterHub.

* Start Julia REPL, `julia`.
* Enter package mode. `]`.
* `add IJulia`.
* `build IJulia`.
* Exit package mode, `Backspace`.
* Exit Julia, `exit()`.

Test in Jupyter.

* Restart Jupyter, `sudo systemctl start jupyterhub` and `sud systemctl stop jupyterhub`.
* Log in to JupyterHub.
* View available environments in the *New* pulldown or view the Lab interface by changing *tree* to *lab* in the URL.


### Add packages

I like functionality and Julia packages add great functionality. For the ability to just use it, I add all of the packages that are included in [Julia Pro's curated packages list](https://juliacomputing.com/products/juliapro.html#curated-pkgs).

* Add the general programming packages,
    * `add DataStructures LightGraphs JuliaWebAPI IJulia Nettle DSP NearestNeighbors Parameters ParserCombinator Libz BenchmarkTools Rebugger Debugger`
* Since I work with graphs regularly, add [additional LightGraphs functionality](https://github.com/JuliaGraphs/LightGraphs.jl#lightgraphs),
    * `add LightGraphsExtras MetaGraphs SimpleWeightedGraphs GraphIO`
* Add math packages, 
    * `add Calculus DataFrames StatsBase Distributions HypothesisTests GLM OnlineStats DifferentialEquations SymPy KernelDensity Zygote`.
* Optimization and databases,
    * `add Optim Roots JDBC`.
* User interfaces and visualizations,
    * `add PyPlot Interact LaTeXStrings Formatting Images Plots GR UnicodePlots ImageMagick StatPlots PGFPlots`.
* Machine learning,
    * `add Knet Clustering DecisionTree MLBase Flux  Metalhead ScikitLearn`.
* Interoperability,
    * `add RCall PyCall Conda`.
* File and data formats,
    * `add JSON JLD2 CSV LightXML StaticArrays ProtoBuf CuArrays`.
* Economics and finance,
    * `add QuantEcon BusinessDays Miletus`.
* Others,
    * `add JuMP Turing JuliaDB`.

### Interact

To use interactive plots, a bit more work needs to be done.

* `conda install nodejs`




TensorFlow is not yet working.