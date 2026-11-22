# syntax=docker/dockerfile:1.7
#
# Content overlay: the lab's two folders, landing where the Labspace kit looks
# for them. No scripts, no tools, no base: `FROM scratch`, so it composes onto
# whatever the workload is. The Docker Scout CLI plugin comes from the
# docker.io/sbx/scout-cli kit (see `requires` in labsbx-dhi-launch-mixin.yaml).
#
# The build context is the repository root (CI, see the README):
#   docker buildx build . -f sbx-kit/labsbx-dhi-launch-mixin.yaml
#
# The `[e]`/`[t]` wildcards make each COPY a no-op when the folder isn't in the
# context, which is the case when sbx builds this folder on its own
# (`--kit ./sbx-kit` from a clone): the Labspace kit then serves the
# workspace's labspace/ and project/ instead.
FROM scratch
COPY labspac[e] /opt/labspace/content/labspace
COPY projec[t] /opt/labspace/content/project
