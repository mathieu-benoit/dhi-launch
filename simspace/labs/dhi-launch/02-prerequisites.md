# Prerequisites

## Container registry prefixes

In the hands-on lab, you first provide the registry URLs the lab pulls from: your Hardened Images registry prefix (for all the DHI images, possibly in your own private registry) and your Docker Hub URL (just for the public PostgreSQL image).

In this simulation, they are set to their industry defaults:

- Hardened Images Container registry URL: $$registry$$
- DockerHub URL: $$dockerhub$$

---

## Docker login

> [!NOTE]
> If you are running the hands-on lab in a Docker Sandbox (`sbx`), you can skip this entire "Docker login" section: the sandbox uses your host's `sbx login` for Docker Scout and for pulls from Docker Hub and `dhi.io`.

## For Docker Scout

Even if you are using your own private container registry (assuming not Docker Hub), you will need to run this command below because this lab uses Docker Scout to continuously scan the container images:

```bash
docker login
```

You should land to this message:

```none no-copy-button no-run-button
Login Succeeded
```

## For dhi.io

Your Hardened Images Container registry URL is `$$registry$$`, so you should also run this command:

```bash
docker login dhi.io
```
