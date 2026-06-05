# Multi-stage: pull a static busybox out of Alpine so the final image
# (built on Dozzle's scratch/distroless base) still has a shell + nc +
# grep to run the mode-aware healthcheck script. busybox-static is the
# only addition over upstream — keeps the wrapper deliberately thin.
FROM alpine:3.21 AS shim
RUN apk add --no-cache busybox-static

FROM amir20/dozzle:latest

COPY --from=shim /bin/busybox.static /busybox
COPY healthcheck.sh /healthcheck.sh

# Mode-aware healthcheck. Server mode (default) calls Dozzle's own
# `/dozzle healthcheck` (HTTP GET on :8080). Agent mode listens on
# :7007 with gRPC/mTLS and has no HTTP /healthcheck endpoint, so the
# script falls back to a TCP probe via busybox nc. The script picks
# the branch by inspecting PID 1's cmdline, so the user does not need
# to set any extra env vars - `command: agent` (or `Post Arguments`
# in Unraid) is enough.
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD ["/busybox", "sh", "/healthcheck.sh"]
