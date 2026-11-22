# Hardened Images Launch Labspace

👋 Welcome to the Hardened Images Launch lab!

> A repository containing a Restaurant reservation (`dinner`) application consisting of a basic Python app talking to a PostgreSQL database to demonstrate the use of your own Hardened Images and their benefits for your users.

During this lab, you will learn to do the following:
- Pull & Run Hardened Images
- Do Multi-stage build with Hardened Images
- Scan continuously with Docker Scout
- Use Compose with Hardened Images

## Run this Labspace

You can run this Labspace in its latest version from anywhere (if you have Docker/Podman and Docker/Podman Compose installed):

```bash
docker compose -f oci://ghcr.io/mathieu-benoit/labspace-dhi-launch:latest up
```

And then open the labspace in your web browser: http://localhost:3030.

## Run this Labspace in a Docker Sandbox (option 2)

You can also run this lab with [`sbx`](https://docs.docker.com/ai/sandboxes/) instead of Docker Compose. Everything (instructions, VS Code, and a private Docker engine for the lab) runs in a single microVM, and `sbx rm` removes everything the lab created. This option uses three [Sandbox Kits](https://github.com/docker/sandbox-kit-spec):

- the **Labspace kit** from [mathieu-benoit/labsbxes](https://github.com/mathieu-benoit/labsbxes), which runs the interface and the IDE;
- the **Docker Scout kit** [`docker.io/sbx/scout-cli`](https://hub.docker.com/r/sbx/scout-cli), which installs the `docker scout` CLI plugin and signs it in to Docker Scout with your host's `sbx login`;
- the **content kit** of this repository (in [sbx-kit/](sbx-kit)), which carries `labspace/` and `project/`, the app port (`5001`) and the network access the lab needs (Docker login, `dhi.io`, `ghcr.io`, PyPI). It requires the other two kits: `sbx` refuses to start it without them.

By default `sbx` only installs kits from `docker.io/` and `dhi.io/`, so first allow the GHCR namespace:

```bash
sbx settings set kit.allowedSources '["docker.io/","dhi.io/","ghcr.io/mathieu-benoit/"]'
```

Then, from an empty folder (`sbx run` mounts the current folder as the workspace):

```bash
sbx run shell --kit ghcr.io/mathieu-benoit/labsbxes/labspace:0.1.4 --kit docker.io/sbx/scout-cli:1.30.0-0 --kit ghcr.io/mathieu-benoit/labsbx-dhi-launch-mixin:0.1.0 -p 8085:8085 -p 5001:5001 --name dhi-launch -d
```

Then open the interface on the host port that `sbx ports dhi-launch` lists for sandbox port `3030` (add `-p 3030:3030` to the command to always use http://localhost:3030).

- `-p 8085:8085` is required: the interface embeds the IDE at `http://localhost:8085`.
- `-p 5001:5001` is for the lab's "App" tab (`http://localhost:5001`).
- The lab's "Docker login" section isn't needed: the sandbox uses your host's `sbx login` for Docker Scout and for pulls from Docker Hub and `dhi.io`. For another private registry, store its credentials on your host with `sbx secret set --registry` (see [Registry credentials](https://docs.docker.com/ai/sandboxes/configuration/credentials/#registry-credentials)).
- Stop the lab with `sbx stop dhi-launch`, restart it with `sbx run --name dhi-launch -d`, delete it with `sbx rm dhi-launch`.

From a clone of this repository, you can run the local version of the content kit instead of the published one:

```bash
sbx run shell --kit ghcr.io/mathieu-benoit/labsbxes/labspace:0.1.4 --kit docker.io/sbx/scout-cli:1.30.0-0 --kit ./sbx-kit -p 8085:8085 -p 5001:5001 --name dhi-launch -d
```

`sbx` builds `./sbx-kit` on its own, so that local kit carries no lab content: the Labspace kit serves the clone's own `labspace/`, and `project/` is the folder on your machine, so your edits land in the clone. Run it from the clone, not from an empty folder. Add `--kit-arg devMode=true` to see markdown edits live.

The content kit is published by [.github/workflows/publish-kit.yaml](.github/workflows/publish-kit.yaml) on every push to `main`, as `ghcr.io/mathieu-benoit/labsbx-dhi-launch-mixin`: `:latest` and `:sha-<short>` follow `main`, and `:<version>` (from `version:` in [sbx-kit/labsbx-dhi-launch-mixin.yaml](sbx-kit/labsbx-dhi-launch-mixin.yaml)) is published the first time that version reaches `main` and never overwritten, so bump `version:` to release a new one. It is built from the repository root (`docker buildx build . -f sbx-kit/labsbx-dhi-launch-mixin.yaml`), which is how the published kit carries `labspace/` and `project/`. Pull requests only build and validate the kit. New GHCR packages can start out private: make the package public after the first publish.

## Contribute to this Labspace

After you cloned this GitHub repository, you can run this Labspace locally by running these commands:

On Mac/Linux:

```bash
CONTENT_PATH=$PWD docker compose up --watch
```

On Windows with PowerShell:

```bash
$Env:CONTENT_PATH = (Get-Location).Path; docker compose up --watch
```

And then open the labspace in your web browser: http://localhost:3030.
