# Dozzle (with Healthcheck)

Thin wrapper over [amir20/dozzle](https://github.com/amir20/dozzle) that adds a Docker HEALTHCHECK.

Dozzle includes a built-in `/dozzle healthcheck` command, but it doesn't work with Docker's `--health-cmd` flag due to a [known limitation](https://dozzle.dev/guide/healthcheck). This wrapper bakes the healthcheck into the Dockerfile so it works on platforms like Unraid that don't support `--health-cmd` in Extra Parameters.

## Image

```
ghcr.io/prophetse7en/dozzle:latest
```

Rebuilt weekly (Mondays 04:00 UTC) to stay current with upstream `amir20/dozzle:latest`.

## What it does

- Uses `amir20/dozzle:latest` as base image (no modifications)
- Adds `HEALTHCHECK` that calls `/dozzle healthcheck` (HTTP request to `localhost:8080/healthcheck`)
- Reports `healthy` when Dozzle's web UI is responding

## Credits

- [Dozzle](https://dozzle.dev/) by [amir20](https://github.com/amir20) — real-time Docker log viewer
