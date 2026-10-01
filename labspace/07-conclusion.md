# Conclusion

You’ve completed the **Hardened Images Launch** lab!

✅ You now know how to:

- Pull & Run Hardened Images
- Do Multi-stage build with Hardened Images
- Use Compose with Hardened Images

Here are the benefits illustrated with the Python container image:

| | Default Python |  DHI Python | |
|-|--------------------|----------------|-|
| CVEs | 12C 88H 84M 267L 93? | 6H 8M 22L 1? | -507 |
| Size (on disk) | 437 MB | 38 MB | -399 MB |
| Number of packages | 492 | 106 | -386 |
| Run-as | `root` | `nonroot` | |
| Package manager | Yes | No | |
| Shell | Yes | No | |

And here are the benefits illustrated with the PostgreSQL container image:

| | Default PostgreSQL |  DHI PostreSQL | |
|-|--------------------|----------------|-|
| CVEs | 8C 38H 40M 74L 6? | 2L | -164 |
| Size (on disk) | 162 MB | 128 MB | -34 MB |
| Number of packages | 205 | 131 | -74 |
| Run-as | `root` | `postgres` | |
| Package manager | Yes | No | |
| Shell | Yes | Yes | |

🎉 Well done!

## Resources

- [Multi-stage builds](https://docs.docker.com/build/building/multi-stage/)
- [Base image hardening](https://docs.docker.com/dhi/core-concepts/hardening/)
- [Troubleshoot hardened images](https://docs.docker.com/dhi/troubleshoot/)