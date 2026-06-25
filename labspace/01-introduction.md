# Introduction

👋 Welcome to the **Hardened Images Launch** lab! During this lab, you will learn to do the following:

- Pull & Run Hardened Images
- Do Multi-stage build with Hardened Images
- Use Compose with Hardened Images

Throughout this lab you will use a repository containing a Restaurant reservation (`dinner`) application consisting of a basic Python app talking to a PostgreSQL database to demonstrate the use of Hardened Images.

---

First things to get started, please provide following registry URLs:

::variableDefinition[registry]{prompt="What is your Hardened Images Container Registry prefix?"}

::variableDefinition[ghcr]{prompt="What is your GitHub Container Registry (ghcr.io) remote repository URL?"}

::variableDefinition[dockerhub]{prompt="What is your DockerHub remote repository URL ?"}

---

If you run this lab locally, and not within the labspace environment, you will also need to clone the project locally:

```bash no-run-button no-copy-button
git clone https://github.com/mathieu-benoit/dhi-launch

cd dhi-launch/project
```
