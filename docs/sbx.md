# Run the lab in a Docker Sandbox

You can run this lab with [`sbx`](https://docs.docker.com/ai/sandboxes/) instead of Docker Compose. Everything (instructions, VS Code, and a private Docker engine for the lab) runs in a single microVM, and `sbx rm` removes everything the lab created.

## The kits

This option uses [Sandbox Kits](https://github.com/docker/sandbox-kit-spec), layered onto the `shell` sandbox:

- the **Labspace kit** from [mathieu-benoit/labsbxes](https://github.com/mathieu-benoit/labsbxes), which runs the interface and the IDE;
- the **Docker Scout kit** [`docker.io/sbx/scout-cli`](https://hub.docker.com/r/sbx/scout-cli), which installs the `docker scout` CLI plugin and signs it in to Docker Scout with your host's `sbx login`;
- the **content kit** of this repository (in [sbx-kit/](../sbx-kit)), which carries `labspace/` and `project/`, the app port (`5001`) and the network access the lab needs (Docker login, `dhi.io`, PyPI). It requires the other two kits: `sbx` refuses to start it without them.

They are also published together as one reference: the **kit set** [labsbx-dhi-launch.yaml](../labsbx-dhi-launch.yaml) merges the three with the `shell` sandbox into a single workload kit, `ghcr.io/mathieu-benoit/labsbx-dhi-launch` (see [Kit sets](https://docs.docker.com/ai/sandboxes/customize/author/kit-sets/)).

## Before you start

By default `sbx` only installs kits from `docker.io/` and `dhi.io/`, so first allow the GHCR namespace:

```bash
sbx settings set kit.allowedSources '["docker.io/","dhi.io/","ghcr.io/mathieu-benoit/"]'
```

## Run the lab

From an empty folder (`sbx run` mounts the current folder as the workspace), run the kit set:

```bash
sbx run ghcr.io/mathieu-benoit/labsbx-dhi-launch:latest -p 8085:8085 -p 5001:5001 --name dhi-launch -d
```

This is the same as passing the three kits yourself onto `shell`:

```bash
sbx run shell --kit ghcr.io/mathieu-benoit/labsbxes/labspace:latest --kit docker.io/sbx/scout-cli:latest --kit ghcr.io/mathieu-benoit/labsbx-dhi-launch-mixin:latest -p 8085:8085 -p 5001:5001 --name dhi-launch -d
```

The set pins the exact version of each kit it was built with, including `shell`, so it changes only when it is republished; passing the three `:latest` kits onto `shell` picks up each one's newest version. Use that form too to add the lab to another agent with a Docker engine (for example `sbx run claude --kit ...`): the set already carries a workload, so it can't be layered onto another one.

Then open the interface on the host port that `sbx ports dhi-launch` lists for sandbox port `3030` (add `-p 3030:3030` to the command to always use http://localhost:3030).

- `-p 8085:8085` is required: the interface embeds the IDE at `http://localhost:8085`.
- `-p 5001:5001` is for the lab's "App" tab (`http://localhost:5001`).
- The lab's "Docker login" section isn't needed: the sandbox uses your host's `sbx login` for Docker Scout and for pulls from Docker Hub and `dhi.io`. For another private registry, store its credentials on your host with `sbx secret set --registry` (see [Registry credentials](https://docs.docker.com/ai/sandboxes/configuration/credentials/#registry-credentials)).
- Stop the lab with `sbx stop dhi-launch`, restart it with `sbx run --name dhi-launch -d`, delete it with `sbx rm dhi-launch`.

## Contribute to the lab

From a clone of this repository, you can run the local version of the content kit instead of the published one:

```bash
sbx run shell --kit ghcr.io/mathieu-benoit/labsbxes/labspace:latest --kit docker.io/sbx/scout-cli:latest --kit ./sbx-kit -p 8085:8085 -p 5001:5001 --name dhi-launch -d
```

`sbx` builds `./sbx-kit` on its own, so that local kit carries no lab content: the Labspace kit serves the clone's own `labspace/`, and `project/` is the folder on your machine, so your edits land in the clone. Run it from the clone, not from an empty folder. Add `--kit-arg devMode=true` to see markdown edits live.

## Tear down the lab

When you are done, delete the sandbox:

```bash
sbx rm dhi-launch
```

This removes everything the lab created: the containers, images, volumes and networks of the sandbox's private Docker engine, and your changes to the lab's project. When you ran from a clone with `./sbx-kit`, your edits to `project/` are in the clone and stay there.

## How the kits are published

Both kits are published by [.github/workflows/publish-kit.yaml](../.github/workflows/publish-kit.yaml) on every push to `main`: first the content kit, `ghcr.io/mathieu-benoit/labsbx-dhi-launch-mixin`, then the kit set, `ghcr.io/mathieu-benoit/labsbx-dhi-launch`, so the set always includes the content kit just published (and the newest `shell`, Labspace and Docker Scout kits).

- For each, `:latest` and `:sha-<short>` follow `main`, and `:<version>` (from `version:` in [sbx-kit/labsbx-dhi-launch-mixin.yaml](../sbx-kit/labsbx-dhi-launch-mixin.yaml) and [labsbx-dhi-launch.yaml](../labsbx-dhi-launch.yaml)) is published the first time that version reaches `main` and never overwritten, so bump `version:` to release a new one.
- The content kit is built from the repository root (`docker buildx build . -f sbx-kit/labsbx-dhi-launch-mixin.yaml`), which is how the published kit carries `labspace/` and `project/`.
- Pull requests only build and validate the kits.
- New GHCR packages can start out private: make the packages public after the first publish.
