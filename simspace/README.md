# Hardened Images Launch lab, as a Simspace

An interactive, fully in-browser version of the [Hardened Images Launch lab](../README.md), built on [Simspace](https://github.com/dockersamples/simspace). Instructions on the left, a simulated terminal on the right: every command and its output is scripted, so it runs the same for everyone, with nothing to install and no Docker account.

It's published at <https://mathieu-benoit.github.io/dhi-launch/simspace/>. Use it to preview the real lab before you take it, to revisit it afterwards, or to teach it where nobody can run Docker. The hands-on lab in [`labspace/`](../labspace) stays the reference; this folder is its translation.

## What's in the translation

One lab, [`labs/dhi-launch/`](labs/dhi-launch), with one section per page of the hands-on lab, from *Introduction* to *Conclusion*. Each hands-on section has **milestones** (15 in total) that check off as the learner runs the right command in the right state.

### What differs from the real lab

- **Outputs are modelled, not captured.** They follow the hands-on lab's text and numbers, and are abridged (a real `docker build` or `docker scout compare` prints more). Treat them as illustrative.
- **Registry prefixes are fixed** to `dhi.io/` and `docker.io`, instead of asked on the *Prerequisites* page.
- **File edits are commands.** The hands-on lab edits the `Dockerfile` and `compose.yaml` in VS Code; here a `sed` command makes the same change, and the multi-stage `Dockerfile` has a **Save** button.
- **`curl` replaces the browser** to reach the application.
- **The figures are the hands-on lab's**: the CVE counts of its `docker scout compare` screenshots, and its on-disk sizes and package counts. A real `docker scout compare` shows compressed sizes, and today's CVE counts differ.
- **The *More tests* page is left out**: it needs a website behind your corporate TLS certificate.

## Author locally

You only need Docker.

```bash
docker compose up dev                 # live preview at http://localhost:5173
docker compose run --rm validate      # validate the lab (fails on errors)
docker compose run --rm replay        # play the whole lab through the engine
```

- `validate` checks the structure: dangling references, commands that match no scenario, unknown milestones.
- `replay` ([`tools/replay.ts`](tools/replay.ts), adapted from [mathieu-benoit/sbx-lab](https://github.com/mathieu-benoit/sbx-lab/tree/main/simspace)) plays every runnable block in order, as the Run buttons would, and fails on blocks that dead-end, blocks that land on an error path (a scenario whose id ends in `-error`), and milestones that never complete. Run it after changing a scenario. Add `-v` for the full output, with `docker compose run --rm replay node scripts/run-ts.mjs scripts/replay.ts /labs/dhi-launch -v`.

On Windows with Git Bash, prefix these commands with `MSYS_NO_PATHCONV=1`, so the `/labs` paths reach the container as they are.

Edit the files under `labs/dhi-launch/` and refresh the browser:

- `labspace.yaml`: title, catalog card, the terminal, sections and milestones, and the seed files of the virtual filesystem (the real project files, copied from [`../project`](../project)).
- `simulator.yaml`: what each command does, gated on a small state tree.
- `*.md`: one file per section.

`labs.json` is generated; never commit it.

The format is specified in [dockersamples/simspace](https://github.com/dockersamples/simspace): `spec/labspace.md` and `spec/simulator.md`.

## Deploy

The [`publish-pages`](../.github/workflows/publish-pages.yaml) workflow publishes this lab in `simspace/` on the repository's Pages site, next to the landing page ([`../site`](../site)), on every push to `main` that changes either. On pull requests it validates and replays the lab without deploying.

## Keeping it in sync

When the hands-on lab changes (a new image tag, a new step, new numbers), update the matching section here: the markdown, the scenarios that produce the output, and the milestones (bump `version:` in `labspace.yaml` when you add, remove or rename one, so stored progress is reset). When `project/` changes, refresh the seed files in `labspace.yaml`. Then run `validate` and `replay`.
