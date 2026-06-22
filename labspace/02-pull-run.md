# Pull & Run

First thing to get started, please provide your Container Registry prefix:

::variableDefinition[registry]{prompt="What is your Container Registry prefix?"}

## Pull the Python image

Pull the hardened Python image from your private registry:

```bash
docker pull $$registry$$python:3.14-debian13
```

## Run the Python image

Run locally this hardened Python image:

```bash
docker run --rm $$registry$$python:3.14-debian13 python -c 'print("Hello, Hardened Image!")'
```

## Test the "No shell" variant

Try to run a shell with this hardened Python image:

```bash
docker run --rm -it $$registry$$python:3.14-debian13 sh
```

## Test the access to internal website

Identify a website with your corporate issued TLS certificate:

::variableDefinition[website]{prompt="What is a website only accessible with your corporate issued TLS certificate?"}

Try to access an internal website from this hardened Python image:

```bash
docker run --rm $$registry$$python:3.14-debian13 python -c 'import urllib.request; print(urllib.request.urlopen("$$website$$", timeout=10).status)'
```

You should see a successful `200` response.