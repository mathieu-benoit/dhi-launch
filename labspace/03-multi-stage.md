# Multi-stage build

## Build the Python image

Build the initial image:

```bash
docker build -t dinner:initial --sbom=true --provenance=mode=max .
```

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

Compare the CVEs between the initial image and the latest hardened  `-dev` image built locally:

```bash
docker scout compare --ignore-unchanged --to dinner:initial dinner:dhi-dev
```

See the number of CVEs, packages and size of the image just got improved:
- CVEs: +1
- Packages: -19
- Size (on disk): -20MB

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

Compare the CVEs between the initial image and the latest hardened image built locally:

```bash
docker scout compare --ignore-unchanged --to dinner:initial dinner:distroless
```

See the number of CVEs, packages and size of the image just got improved:
- CVEs: -15
- Packages: -76
- Size (on disk): -112MB
