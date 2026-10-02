# More tests

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