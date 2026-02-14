# Bugs

## 1. `rc` variable is undeclared and leaks scope in search loop

In the search loop error handler (line 105-108), the variable `rc` is never declared with `local`. It leaks into the global shell scope and retains stale values across iterations.

## 2. `rc` variable is undeclared and leaks scope in fix loop

Same issue as #1 but in the fix loop error handler (line 117-119).

## 3. Word splitting on `$TERMINAL` breaks for paths with spaces

`$TERMINAL` is used unquoted as a command (lines 104, 107, 117, 119), relying on word splitting. If the terminal path contains spaces, the command will break. An array or `eval` would be more robust.

## 4. Auto-update URL construction assumes tag has no `v` prefix but then prepends one

`auto_update` strips a leading `v` from the tag to get `remote_version` (line 13), then constructs the download URL as `v$remote_version` (line 18). If a release tag is published without a `v` prefix (e.g., `1.0.0`), the resulting URL will be `v1.0.0`, which won't match the actual tag. The `install.sh` script does not have this problem because it uses the raw tag value.
