# Multi-stage build

## Update the Dockerfile to use an hardened `dev` base image

Change the base image in the `FROM` instruction in the :fileLink[Dockerfile]{path="Dockerfile" line=1} and save.

```yaml no-copy-button
FROM $$registry$$python:3.14-debian13-dev
```

```diff no-copy-button
- FROM python:3.14
+ FROM $$registry$$python:3.14-debian13-dev
```

Build the updated image with the hardened `dev` variant:

```bash no-run-button no-copy-button
podman build -t dinner:dev .
```

If you have Docker Scout, compare the CVEs between the initial image and the latest hardened `dev` image built locally:

```bash no-run-button no-copy-button
docker scout compare \
    --ignore-unchanged \
    --to $$ghcr$$/mathieu-benoit/dinner:initial@sha256:a8b1c9e163a383400b018d5009b9323b08d25461c2ceba9ed03f4c8f32c3d960 \
    dinner:dev
```

See the number of CVEs, packages and size of the image just got improved:
- CVEs: -232
- Packages: -367
- Size (on disk): -1443MB

## Test the "shell" variant

Try to run a shell with this hardened `dev` image built locally:

```bash no-run-button no-copy-button
podman run --rm -it dinner:dev sh
```

You can run some commands because this `dev` variant image has a shell, a package manager and extra system packages.

Exit the opened shell:

```bash no-run-button no-copy-button
exit
```

## Update the Dockerfile to use a runtime base image

Update the :fileLink[Dockerfile]{path="Dockerfile"} with this content:

```yaml no-copy-button
FROM $$registry$$python:3.14-debian13-dev AS builder
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app
RUN pip install psycopg2-binary --target /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target /app

FROM $$registry$$python:3.14-debian13 AS runtime
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
COPY --from=builder /app /app
COPY . /app
EXPOSE 5000
CMD ["python", "/app/app.py"]
```

```bash no-run-button no-copy-button
podman build -t dinner:runtime .
```

If you have Docker Scout, compare the CVEs between the `dev` and the `runtime` hardened images built locally:

```bash no-run-button no-copy-button
docker scout compare --ignore-unchanged --to dinner:dev dinner:runtime
```

See the number of CVEs, packages and size of the image just got improved:
- CVEs: -16
- Packages: -57
- Size (on disk): -92MB

## Test the "no shell" variant

Try to run a shell with this hardened `runtime` image built locally:

```bash no-run-button no-copy-button
podman run --rm -it dinner:runtime sh
```

You get this error message:

```none no-copy-button
OCI runtime create failed: runc create failed: unable to start container process: error during container init: exec: "sh": executable file not found in $PATH
```

You cannot run any commands because this `runtime` variant image doesn't have a shell, a package manager or any extra system packages.

_Note: Out of scope of this workshop, but instead, you can use the `docker debug` or `kubectl debug` commands to attach a temporary, tool-rich debug container to the running instance._
