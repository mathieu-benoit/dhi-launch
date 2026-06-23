# Multi-stage build

## Update the Dockerfile to use an hardened `-dev` base image

Change the base image in the `FROM` instruction in the :fileLink[Dockerfile]{path="Dockerfile" line=1} and save.

```yaml
FROM $$registry$$python:3.14-debian13-dev
```

```diff no-copy-button
- FROM python:3.14-slim
+ FROM $$registry$$python:3.14-debian13-dev
```

Build the updated image with the hardened `-dev` variant:

```bash
docker build -t dinner:dhi-dev .
```

Compare the CVEs between the initial image and the latest hardened `-dev` image built locally:

```bash
docker scout compare --ignore-unchanged --to ghcr.io/mathieu-benoit/dinner:initial dinner:dhi-dev
```

See the number of CVEs, packages and size of the image just got improved:
- CVEs: +1
- Packages: -19
- Size (on disk): -20MB

## Test the "shell" variant

Try to run a shell with this hardened `-dev` image built locally:

```bash
docker run --rm -it dinner:dhi-dev sh
```

You can run some commands because this `-dev` variant image has a shell, a package manager and extra system packages.

## Update the Dockerfile to use a distroless base image

Update the :fileLink[Dockerfile]{path="Dockerfile"} with this content:

```yaml save-as=Dockerfile
FROM $$registry$$python:3.14-debian13-dev AS builder
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app
RUN pip install psycopg2-binary --target /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --target /app

FROM $$registry$$python:3.14-debian13 AS prod
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
COPY --from=builder /app /app
COPY . /app
EXPOSE 5000
CMD ["python", "/app/app.py"]
```

```bash
docker build -t dinner:distroless .
```

Compare the CVEs between the initial image and the hardened `distroless` image built locally:

```bash
docker scout compare --ignore-unchanged --to ghcr.io/mathieu-benoit/dinner:initial dinner:distroless
```

See the number of CVEs, packages and size of the image just got improved:
- CVEs: -15
- Packages: -76
- Size (on disk): -112MB

## Test the "no shell" variant

Try to run a shell with this hardened `distroless` image built locally:

```bash
docker run --rm -it dinner:distroless sh
```

You cannot run any commands because this `distroless` variant image doesn't have a shell, a package manager or any extra system packages.
