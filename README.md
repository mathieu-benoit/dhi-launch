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
