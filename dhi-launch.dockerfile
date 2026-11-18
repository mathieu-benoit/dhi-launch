# syntax=docker/dockerfile:1.7
#
# Content overlay: the lab's two folders, landing where the Labspace kit looks
# for them, plus the Docker Scout CLI plugin the lab uses (`docker scout
# compare`), which the sandbox's `shell` agent doesn't ship. No base image:
# the result is `FROM scratch`, so it composes onto whatever the workload is.

# The plugin is a single static binary, published for linux/amd64 and
# linux/arm64. Bump the tag to update it.
FROM docker/scout-cli:1.29.0 AS scout

FROM scratch
COPY --from=scout --chmod=755 /docker-scout /usr/local/lib/docker/cli-plugins/docker-scout
COPY labspace /opt/labspace/content/labspace
COPY project /opt/labspace/content/project
