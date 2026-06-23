# Introduction

👋 Welcome to the **Hardened Images Launch** lab! During this lab, you will learn to do the following:

- Pull & Run Hardened Images
- Do Multi-stage build with Hardened Images
- Use Compose with Hardened Images

First things to get started, please provide following registry URLs:

::variableDefinition[registry]{prompt="What is your Hardened Images Container Registry prefix?"}

::variableDefinition[ghcr]{prompt="What is your GitHub Container Registry (ghcr) remote repository URL?"}

::variableDefinition[dockerhub]{prompt="What is your DockerHub remote repository URL ?"}

Alternatively, if no customization are needed, you can set their value to their industry default:
 ::variableSetButton[Set default URLs]{variables="registry=dhi.io/,ghcr=ghcr.io,dockerhub=docker.io"}

---

Configured registry URLs:

- Hardened Images Container registry URL: $$registry$$
- GitHub Container Registry URL: $$ghcr$$
- DockerHub URL: $$dockerhub$$

---

FIXME/TODOs:
- Pre-build the initial image
- PDF
