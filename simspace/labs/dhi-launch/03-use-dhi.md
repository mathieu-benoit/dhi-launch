# Use DHI

In this section you will first build the application with its initial `Dockerfile`, then replace the public Python image used in the `FROM` instruction by the DHI Python `-dev` variant. And see already great benefits with it!

## Build the initial image

Look at the initial :filelink[Dockerfile]{path="Dockerfile"}: it uses the public `python:3.14` image as its base image.

Build the initial image with this `Dockerfile`:

```bash
docker build --pull -t dinner:initial .
```

This `dinner:initial` image is the baseline you will compare the hardened images against.

## Update the Dockerfile to use an hardened `dev` base image

Change the base image in the `FROM` instruction of the `Dockerfile`:

```diff no-copy-button no-run-button
- FROM python:3.14
+ FROM $$registry$$python:3.14-debian13-dev
```

In the hands-on lab you make this change in VS Code. Here, this command makes it for you:

```bash
sed -i 's|FROM python:3.14|FROM $$registry$$python:3.14-debian13-dev|' Dockerfile
```

Check the result in the :filelink[Dockerfile]{path="Dockerfile"}.

Build the updated image with the hardened `dev` variant:

```bash
docker build --pull -t dinner:dev .
```

Compare the CVEs between the initial image and the hardened `dev` image, both built locally:

```bash
docker scout compare --ignore-unchanged --to local://dinner:initial local://dinner:dev
```

✅ See the number of CVEs, packages and size of the image just got improved:
- CVEs: -271
- Packages: -328
- Size (on disk): -1.43 GB
- Run-as: `root`

## Test the "shell" variant

Try to run a shell with this hardened `dev` image built locally:

```bash
docker run --rm -it dinner:dev sh
```

You can run some commands because this `dev` variant image has a shell, a package manager and extra system packages.

```bash
whoami
```

```bash
cat /etc/os-release
```

```bash
pip --version
```

```bash
apt --version
```

Exit the opened shell:

```bash
exit
```
