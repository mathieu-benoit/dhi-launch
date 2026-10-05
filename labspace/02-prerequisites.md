# Prerequisites

## Container registry prefixes

First things to get started, please provide the following registry URLs:

::variableDefinition[registry]{prompt="What is your Hardened Images Container Registry prefix (this is for all the DHI images in your own private registry)?"}

::variableDefinition[ghcr]{prompt="What is your GitHub Container Registry (ghcr.io) remote repository URL (this is only for the pre-built dinner:initial image)?"}

::variableDefinition[dockerhub]{prompt="What is your DockerHub remote repository URL (this is just for the public PostgreSQL image)?"}

Alternatively, if no customization are needed, you can set their value to their industry default:
 ::variableSetButton[Set default URLs]{variables="registry=dhi.io/,ghcr=ghcr.io,dockerhub=docker.io"}

---

Configured registry URLs:

- Hardened Images Container registry URL: $$registry$$
- GitHub Container Registry URL: $$ghcr$$
- DockerHub URL: $$dockerhub$$

---

## Docker login

## For Docker Scout

Even if you are using your own private container registry (assuming not Docker Hub), you will need to run this command below because this labspace use Docker Scout to continuously scan the container images:
```bash
docker login
```

You should land to this message:
```none no-copy-button
Login Succeeded
```

## For dhi.io

If your Hardened Images Container registry URL (value you set: $$registry$$) is dhi.io, you should also run this command:
```bash
docker login dhi.io
```
