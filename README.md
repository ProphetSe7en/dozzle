# Dozzle (with Healthcheck)

Same Dozzle you know, with a working healthcheck baked in. Drop-in replacement for `amir20/dozzle:latest`.

```
ghcr.io/prophetse7en/dozzle:latest
```

Rebuilt every Monday so it stays current with upstream.

## Why this wrapper exists

Dozzle has a built-in healthcheck command, but it does not work with Unraid's healthcheck settings out of the box. This wrapper sets it up for you so the container shows as healthy in Unraid (and other tools that read Docker's healthcheck).

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
      - DOZZLE_HOSTNAME=my-remote-host
```

The healthcheck figures out which mode you are in and checks the right port. Nothing extra to set.

## Unraid

Two templates in this repo:

- `unraid-template.xml` for the main UI.
- `unraid-template-agent.xml` for a remote agent. Pre-filled so installing it from Community Applications is one click. Set Dozzle Hostname before you start it.

## Credits

- [Dozzle](https://dozzle.dev/) by [amir20](https://github.com/amir20)
