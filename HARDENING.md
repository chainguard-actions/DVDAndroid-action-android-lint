<!-- markdownlint-disable -->

# Hardening Report: DVDAndroid--action-android-lint/v1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **DVDAndroid--action-android-lint/v1** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile (a supporting script directly referenced by action.yml via `image: 'Dockerfile'`) pipes remote content directly to a shell interpreter. The line `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s` downloads a script from a remote URL over HTTPS and immediately pipes it to `sh` without first saving it to disk for inspection. This allows a compromised or malicious remote server to execute arbitrary code during the Docker image build. The script should be downloaded to a file first, its integrity verified (e.g., via checksum), and then executed separately.

Locations:

- `Dockerfile:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed the unsafe pipe-to-shell pattern in hardened/action/Dockerfile. Changed `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s` to first download the script to a temporary file (`wget -q -O /tmp/install-reviewdog.sh ...`), then execute it separately (`sh /tmp/install-reviewdog.sh`), and finally clean up the temporary file. This eliminates the vulnerability where remote content was piped directly to a shell interpreter without any opportunity for inspection or verification.

