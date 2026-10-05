# Conclusion

You’ve completed the **Hardened Images Launch** lab!

✅ You now know how to:

- Pull & Run Hardened Images
- Do Multi-stage build with Hardened Images
- Use Compose with Hardened Images

Here are the benefits illustrated with the Python container image:

| | Default Python |  DHI Python | |
|-|--------------------|----------------|-|
| CVEs | 1C 35H 33M 219L 27? | 9H 7M 12L | -287 |
| Size (on disk) | 1.71 GB | 153 MB | -1.56 GB |
| Number of packages | 510 | 107 | -403 |
| Run-as | `root` | `nonroot` | |
| Package manager | Yes | No | |
| Shell | Yes | No | |

And here are the benefits illustrated with the PostgreSQL container image:

| | Default PostgreSQL |  DHI PostreSQL | |
|-|--------------------|----------------|-|
| CVEs | 8C 38H 40M 74L 6? | 2L | -164 |
| Size (on disk) | 650 MB | 568 MB | -82 MB |
| Number of packages | 205 | 131 | -74 |
| Run-as | `root` | `postgres` | |
| Package manager | Yes | No | |
| Shell | Yes | Yes | |

🎉 Well done!

## Resources

- [Multi-stage builds](https://docs.docker.com/build/building/multi-stage/)
- [Base image hardening](https://docs.docker.com/dhi/core-concepts/hardening/)
- [Distroless images](https://docs.docker.com/dhi/explore/security-concepts/distroless/)
- [Troubleshoot hardened images](https://docs.docker.com/dhi/troubleshoot/)