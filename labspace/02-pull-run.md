# Pull & Run

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

You get this error message:

```none no-copy-button
OCI runtime exec failed: exec failed: unable to start container process: exec: "sh": executable file not found in $PATH
```

You cannot run any commands because this `runtime` variant image doesn't have a shell, a package manager or any extra system packages. We will illustrate this part in the next section.

## Test the access to internal website

Identify a website with your corporate issued TLS certificate:

::variableDefinition[website]{prompt="What is a website only accessible with your corporate issued TLS certificate?"}

```bash
echo "Q" | openssl s_client -connect $$website$$:443 -showcerts 2>/dev/null | openssl x509 -noout -issuer
```

Try to access an internal website from this hardened Python image:

```bash
docker run --rm $$registry$$python:3.14-debian13 python -c 'import urllib.request; print(urllib.request.urlopen("https://$$website$$", timeout=10).status)'
```

You should see a successful `200` response.