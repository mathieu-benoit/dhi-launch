# Multi-stage build

## Update the Dockerfile to use an hardened `dev` base image

Change the base image in the `FROM` instruction in the :fileLink[Dockerfile]{path="Dockerfile" line=1} and save.

```yaml
FROM $$registry$$python:3.14-debian13-dev
```

```diff no-copy-button
- FROM python:3.14
+ FROM $$registry$$python:3.14-debian13-dev
```

Build the updated image with the hardened `dev` variant:

```bash
docker build -t dinner:dev .
```

Compare the CVEs between the initial image and the latest hardened `dev` image built locally:

```bash
docker scout compare \
    --ignore-unchanged \
    --to $$ghcr$$/mathieu-benoit/dinner:initial \
    dinner:dev
```

![](images/scout-compare-initial-dev.png)

See the number of CVEs, packages and size of the image just got improved:
- CVEs: -491
- Packages: -311
- Size (on disk): -373MB
- Run-as: `root`

## Test the "shell" variant

Try to run a shell with this hardened `dev` image built locally:

```bash
docker run --rm -it dinner:dev sh
```

You can run some commands because this `dev` variant image has a shell, a package manager and extra system packages.

```bash
whomai
cat /etc/os-release
```

Exit the opened shell:

```bash
exit
```

## Update the Dockerfile to use a runtime base image

Update the :fileLink[Dockerfile]{path="Dockerfile"} with this content:

```yaml save-as=Dockerfile
FROM $$registry$$python:3.14-debian13-dev AS builder
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app
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

```bash
docker build -t dinner:runtime .
```

Compare the CVEs between the `dev` and the `runtime` hardened images built locally:

```bash
docker scout compare \
    --ignore-unchanged \
    --to dinner:dev \
    dinner:runtime
```

![](images/scout-compare-dev-runtime.png)

See the number of CVEs, packages and size of the image just got improved:
- CVEs: -16
- Packages: -75
- Size (on disk): -26MB
- Run-as: `root` --> `nonroot`

## Test the "no shell" variant

Try to run a shell with this hardened `runtime` image built locally:

```bash
docker run --rm -it dinner:runtime sh
```

You get this error message:

```none no-copy-button
OCI runtime create failed: runc create failed: unable to start container process: error during container init: exec: "sh": executable file not found in $PATH
```

You cannot run any commands because this `runtime` variant image doesn't have a shell, a package manager or any extra system packages.

_Note: Out of scope of this workshop, but instead, you can use the `docker debug` or `kubectl debug` commands to attach a temporary, tool-rich debug container to the running instance._
