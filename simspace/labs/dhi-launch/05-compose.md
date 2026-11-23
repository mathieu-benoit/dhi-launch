# Docker Compose

In this section you will see how you use a DHI PostgreSQL image in your Docker Compose file.

## Modify the Docker Compose file to use the PostgreSQL image

Change the `db` image in the :filelink[compose.yaml]{path="compose.yaml"}:

```diff no-copy-button no-run-button
- image: postgres:18
+ image: $$registry$$postgres:18-debian13
```

In the hands-on lab you make this change in VS Code. Here, this command makes it for you:

```bash
sed -i 's|image: postgres:18|image: $$registry$$postgres:18-debian13|' compose.yaml
```

## Run the application

Run the application:

```bash
docker compose up -d --build
```

Check that the containers are running successfully:

```bash
docker ps
```

In the hands-on lab, you now open the application in the browser, at `http://localhost:5001`, and enter a reservation to confirm that the application is working. Here, `curl` stands in for the browser:

```bash
curl http://localhost:5001
```

## Scan the PostgreSQL image

Compare the CVEs between the initial PostgreSQL image and the hardened PostgreSQL image:

```bash
docker scout compare --ignore-unchanged --to registry://$$dockerhub$$/postgres:18 registry://$$registry$$postgres:18-debian13
```

✅ See the number of CVEs, packages and size of the image just got improved:
- CVEs: -115
- Packages: -74
- Size (on disk): -82 MB
- Run-as: `root` --> `postgres`
