# Compose

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

## Scan the PostgreSQL image

Compare the CVEs between the initial PostgreSQL image and the hardened PostgreSQL image:

```bash no-run-button no-copy-button
docker scout compare --ignore-unchanged --to postgres:18 $$registry$$postgres:18-debian13
```

See the number of CVEs, packages and size of the image just got improved:
- CVEs: -44
- Packages: -67
- Size (on disk): 99MB