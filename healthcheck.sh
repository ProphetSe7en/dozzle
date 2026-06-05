#!/busybox sh
# Mode-aware healthcheck for the Dozzle wrapper.
#
# Server mode: Dozzle runs as PID 1 with no extra arg, exposes HTTP on
# :8080. `/dozzle healthcheck` handles that case natively.
#
# Agent mode: Dozzle runs as `/dozzle agent`, exposes gRPC/mTLS on
# :7007, and has no HTTP /healthcheck endpoint. A plain TCP connect to
# 7007 is enough to confirm the agent is listening.
#
# Detection: scan PID 1's cmdline for the literal "agent" token. NUL-
# separated so we tr it to newlines first, then grep for the exact word.

set -e

CMDLINE=$(/busybox tr '\0' '\n' < /proc/1/cmdline)

if echo "$CMDLINE" | /busybox grep -qx 'agent'; then
  exec /busybox nc -z localhost 7007
fi

exec /dozzle healthcheck
