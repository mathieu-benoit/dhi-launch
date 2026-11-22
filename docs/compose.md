# Run the lab with Docker Compose

This is the original way to run this Labspace, on the [labspace-infra](https://github.com/dockersamples/labspace-infra) Compose stack. It works anywhere Docker (or Podman) and Docker Compose (or Podman Compose) are installed.

## Run the published lab

You can run this Labspace in its latest version from any folder:

```bash
docker compose -f oci://ghcr.io/mathieu-benoit/labspace-dhi-launch:latest up
```

Then open the Labspace in your web browser: http://localhost:3030.

The lab's "App" tab opens the dinner application at http://localhost:5001 once you start it in the "Docker Compose" section of the lab.

Follow the lab's "Docker login" section: with this setup, `docker login` is needed for Docker Scout and, when your registry prefix is `dhi.io/`, `docker login dhi.io` to pull the hardened images.

## Contribute to the lab

After you clone this repository, run the Labspace from your clone with these commands:

On Mac/Linux:

```bash
CONTENT_PATH=$PWD docker compose up --watch
```

On Windows with PowerShell:

```bash
$Env:CONTENT_PATH = (Get-Location).Path; docker compose up --watch
```

Then open the Labspace in your web browser: http://localhost:3030.

The stack is defined by [compose.yaml](../compose.yaml), which includes the labspace-infra development stack, and [compose.override.yaml](../compose.override.yaml), which points it at this repository and sets the workspace image.

## How it is published

[.github/workflows/publish-labspace.yaml](../.github/workflows/publish-labspace.yaml) publishes the Labspace to `ghcr.io/mathieu-benoit/labspace-dhi-launch` on every push to `main`, with the [publish-labspace-action](https://github.com/dockersamples/publish-labspace-action).
