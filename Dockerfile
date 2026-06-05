FROM amir20/dozzle:latest
# Dozzle's built-in healthcheck command picks the right check for the
# active mode: HTTP probe on :8080 in server mode, Docker connectivity
# check in agent mode. Works for both modes with the same one-liner.
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD ["/dozzle", "healthcheck"]
