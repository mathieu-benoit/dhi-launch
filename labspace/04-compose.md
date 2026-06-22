# Compose

## Modify the Dockerfile to use the hardened Python image

Change the base image in the `FROM` in the :fileLink[Dockerfile]{path="Dockerfile" line=1} and save.

```yaml
FROM $$registry$$python:3.14-debian13-dev
```

```diff no-copy-button
- FROM python:3.14-slim
+ FROM $$registry$$python:3.14-debian13-dev
```

## Modify the Docker Compose file to use the PostgreSQL image

Change the db image in the :fileLink[compose.yaml]{path="compose.yaml" line=12} and save.

```yaml
image: $$registry$$postgres:18-debian13
```

```diff no-copy-button
- image: postgres:18
+ image: $$registry$$postgres:18-debian13
```

## Run the application

Run the application:
```bash
docker compose up -d --build
```

Go to the application in the browser: :tabLink[http://localhost:5001]{href="http://localhost:5001" title="App" id=app}.

Enter a reservation using the application to confirm that the application is working.