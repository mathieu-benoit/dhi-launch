# Prerequisites

First things to get started, please provide the following registry URLs:

::variableDefinition[registry]{prompt="What is your Hardened Images Container Registry prefix?"}

::variableDefinition[ghcr]{prompt="What is your GitHub Container Registry (ghcr.io) remote repository URL?"}

::variableDefinition[dockerhub]{prompt="What is your DockerHub remote repository URL ?"}

Alternatively, if no customization are needed, you can set their value to their industry default:
 ::variableSetButton[Set default URLs]{variables="registry=dhi.io/,ghcr=ghcr.io,dockerhub=docker.io"}

---

Configured registry URLs:

- Hardened Images Container registry URL: $$registry$$
- GitHub Container Registry URL: $$ghcr$$
- DockerHub URL: $$dockerhub$$

---
