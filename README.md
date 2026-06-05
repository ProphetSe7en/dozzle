# Dozzle (with Healthcheck)

Same Dozzle you know, with a working healthcheck baked in. Drop-in replacement for `amir20/dozzle:latest`.

```
ghcr.io/prophetse7en/dozzle:latest
```

Rebuilt every Monday so it stays current with upstream.

## Why this wrapper exists

Dozzle has a built-in healthcheck command, but it does not work with Unraid's healthcheck settings out of the box. This wrapper sets it up for you so the container shows as healthy in Unraid (and other tools that read Docker's healthcheck).

The same healthcheck works for both server and agent mode. Dozzle's own `/dozzle healthcheck` command picks the right check for whichever mode the container is running in (HTTP probe in server mode, Docker connectivity check in agent mode).

## Use as the main UI

```yaml
services:
  dozzle:
    image: ghcr.io/prophetse7en/dozzle:latest
    ports:
      - 8080:8080
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

Open `http://your-host:8080`.

## Use as an agent on another host

Agent mode sends logs from a remote machine to your main Dozzle. Same image, just add `command: agent` and use port 7007:

```yaml
services:
  dozzle-agent:
    image: ghcr.io/prophetse7en/dozzle:latest
    command: agent
    ports:
      - 7007:7007
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - DOZZLE_HOSTNAME=my-remote-host    # optional, friendly name in the main UI
```

By default the agent uses a self-signed certificate. That is fine on a private network. If the agent will be reachable from the internet, mount your own certificate as described in the [Dozzle agent docs](https://dozzle.dev/guide/agent).

## Unraid

Two templates in this repo:

- `unraid-template.xml` for the main UI.
- `unraid-template-agent.xml` for a remote agent. Pre-filled so installing it from Community Applications is one click.

## Credits

- [Dozzle](https://dozzle.dev/) by [amir20](https://github.com/amir20)
