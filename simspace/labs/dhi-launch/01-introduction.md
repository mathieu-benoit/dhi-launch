# Introduction

👋 Welcome to the **Hardened Images Launch** lab! During this lab, you will learn to do the following:

- Pull & Run Hardened Images
- Do Multi-stage build with Hardened Images
- Use Compose with Hardened Images
- Continuous scanning with Docker Scout

Throughout this lab you will use a repository containing a Restaurant reservation (`dinner`) application consisting of a basic Python app talking to a PostgreSQL database to demonstrate the use of Hardened Images.

## This is the simulated version of the lab

This is a **simulated** version of the [hands-on lab](https://github.com/mathieu-benoit/dhi-launch): every command runs in your browser and is scripted, so there is nothing to install and no Docker account to use. Use it to preview the lab before you take it, to revisit it afterwards, or to follow it where you can't run Docker.

- **Run buttons.** Every command in these pages has a **Run** button: it types the command in the terminal on the right and runs it. You can also type it yourself.
- **The project.** The terminal is opened on the lab's project: the `dinner` app's `Dockerfile`, `app.py`, `compose.yaml`, `requirements.txt` and `templates/`. `ls` and `cat` work on them, and the file links in these pages show them in the terminal.
- **Editing files.** In the hands-on lab, you edit the `Dockerfile` and `compose.yaml` in VS Code. Here, a command makes the same change for you, or a **Save** button writes the whole file.
- **Progress.** Each section lists milestones; they get checked off as you run the right command at the right moment.
- **Stuck?** The **Reset** button puts the simulated machine back to its starting state. Your progress is kept.

> **What is simulated:** the commands the lab asks you to run. Their outputs are modelled on the real ones and abridged (a real `docker build` or `docker scout compare` prints more), and the numbers are the ones the hands-on lab shows. Anything else you type answers that the command isn't part of the lab.

To run the lab for real, see the [other ways to run it](https://mathieu-benoit.github.io/dhi-launch/): in a Docker Sandbox, or with Docker Compose.
