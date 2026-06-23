<!-- markdownlint-disable -->

# Hardening Report: DVDAndroid--action-android-lint/v1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **DVDAndroid--action-android-lint/v1.2** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile downloads a remote install script and pipes it directly to 'sh' without first saving it to a file for inspection. This pattern executes arbitrary remote code and is vulnerable to supply-chain attacks or MITM. Offending line: `RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s`

Locations:

- `Dockerfile:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed the unsafe pipe-to-shell pattern in the Dockerfile. Replaced `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s` with a two-step approach: first download the script to `/tmp/install-reviewdog.sh`, then execute it with `sh`, and finally remove the temporary file. This eliminates the MITM/supply-chain risk of piping remote content directly to a shell interpreter.

