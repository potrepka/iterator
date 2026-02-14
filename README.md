# Iterator

Iterator finds bugs in a pull request and fixes them one by one. It uses any coding terminal (OpenCode, Claude Code, etc.) to do the actual work.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/potrepka/iterator/main/install.sh | bash
```

## Usage

Run this inside a git repository.

```bash
iterator PR [OPTIONS]
```

### Arguments

| Flag | Default | Description |
|------|---------|-------------|
| `PR` | *(required)* | Pull request number |

### Options

| Flag | Default | Description |
|------|---------|-------------|
| `--terminal` | `opencode run` | Command to run the coding terminal |
| `--prompt` | `/review $PR` | Prompt sent to the terminal (`$PR` and `$BRANCH` are replaced) |
| `--output` | `bugs/$BRANCH.md` | File where bugs are collected (`$PR` and `$BRANCH` are replaced) |
| `--search` | `8` | Search iterations per round |
| `--loop` | `64` | Upper bound of fix iterations per round |
| `--repeat` | `8` | Number of rounds |

### Examples

Different terminals:

```bash
iterator 10
iterator 11 --terminal "claude -p"
iterator 12 --terminal "codex exec"
iterator 13 --terminal "gemini -p"
```

Custom prompt and output:

```bash
iterator 14 --prompt '/audit $PR'
iterator 15 --output 'output/$BRANCH.md'
```

> **Note:** Use single quotes for `--prompt` and `--output` values. Double quotes will cause the shell to expand `$PR` and `$BRANCH` before Iterator can substitute them.

Fewer iterations:

```bash
iterator 16 --search 4 --repeat 2
```

## How It Works

Each round has two phases:

1. **Search:** Runs the review prompt for `--search` iterations in separate terminal sessions. Each session appends any bugs it finds to the output file, skipping duplicates.
2. **Fix:** Picks the easiest bug to fix from the file, fixes it, removes it from the file, deletes the file if empty, commits the changes, and pushes. Repeats until the file is deleted or `--loop` iterations is reached.

The script runs **Search** and **Fix** for `--repeat` rounds, then exits.

## Versioning

The script checks for a newer version on each run and updates itself if one is available.

## License

MIT
