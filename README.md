# Hardened Images Launch Labspace

👋 Welcome to the Hardened Images Launch lab!

> A repository containing a Restaurant reservation (`dinner`) application consisting of a basic Python app talking to a PostgreSQL database to demonstrate the use of your own Hardened Images and their benefits for your users.

During this lab, you will learn to do the following:
- Pull & Run Hardened Images
- Do Multi-stage build with Hardened Images
- Scan continuously with Docker Scout
- Use Compose with Hardened Images

## Run this Labspace

There are two ways to run this lab:

- **[With Docker Compose](docs/compose.md)**: the Labspace on the labspace-infra Compose stack, with Docker (or Podman) and Docker Compose (or Podman Compose):

  ```bash
  docker compose -f oci://ghcr.io/mathieu-benoit/labspace-dhi-launch:latest up
  ```

- **[In a Docker Sandbox](docs/sbx.md)**: the Labspace in a single microVM with `sbx`, from one kit set (or the kits it combines), once `sbx` is allowed to install kits from GHCR (see [Before you start](docs/sbx.md#before-you-start)):

  ```bash
  sbx run ghcr.io/mathieu-benoit/labsbx-dhi-launch:latest -p 8085:8085 -p 5001:5001 --name dhi-launch -d
  ```

Each page covers the prerequisites, how to open the lab, how to run it from a clone of this repository to contribute, and how it is published.
