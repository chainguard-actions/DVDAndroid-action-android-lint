<!-- markdownlint-disable -->

# Hardening Report: DVDAndroid--action-android-lint/v1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **DVDAndroid--action-android-lint/v1.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile downloads a remote install script and pipes it directly to `sh` without first saving it to a file for inspection. This allows arbitrary code execution if the remote URL is compromised. Offending line: `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s`

Locations:

- `Dockerfile:5`

### script-injection (severity: high)

Rule (b) violation: entrypoint.sh expands user-controlled input variables without double-quoting, allowing shell metacharacter injection. (1) `$GITHUB_WORKSPACE/${INPUT_LINT_XML_FILE}` — INPUT_LINT_XML_FILE is derived from the user-supplied `inputs.lint_xml_file` and is unquoted, so a value containing spaces, semicolons, or other shell metacharacters will be interpreted by the shell. (2) `${INPUT_REVIEWDOG_FLAGS}` at the end of the reviewdog invocation is also unquoted, and this input is explicitly user-controlled (`inputs.reviewdog_flags`). Both should be double-quoted: `"$GITHUB_WORKSPACE/${INPUT_LINT_XML_FILE}"` and `"${INPUT_REVIEWDOG_FLAGS}"`.

Locations:

- `entrypoint.sh:5`
- `entrypoint.sh:6`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell, script-injection

**Notes:**

Dockerfile: replaced `wget -O - -q <url> | sh -s` with a two-step approach that downloads the script to /tmp/install-reviewdog.sh first, then executes it with `sh`, then removes it — eliminating the unsafe pipe-from-internet pattern. entrypoint.sh: added double-quotes around both unquoted user-controlled variables: `$GITHUB_WORKSPACE/${INPUT_LINT_XML_FILE}` → `"$GITHUB_WORKSPACE/${INPUT_LINT_XML_FILE}"` and `${INPUT_REVIEWDOG_FLAGS}` → `"${INPUT_REVIEWDOG_FLAGS}"` to prevent shell metacharacter injection.

