---
name: codex-review
description: Run a code review using the local OpenAI `codex` CLI. Use ONLY when the user names codex explicitly — "codex review", "run codex on this branch", "what does codex say". Do NOT use for generic review requests like "review my changes" or "look for bugs"; those belong to /code-review, which stays local. This one uploads the diff to OpenAI.
---

# Codex Review

`codex` is OpenAI's review CLI, run locally against a diff in the current repo. **It uploads that diff to OpenAI**, so it runs only when the user has asked for it by name. Never reach for it as a general-purpose reviewer, and never run it on a repo the user hasn't pointed you at.

If `codex` isn't on PATH, say so and stop — don't offer to install it.

## Pick the scope

Three mutually exclusive modes:

| Flag | Reviews |
|------|---------|
| `--base <BRANCH>` | This branch against a base — the usual case |
| `--uncommitted` | Staged, unstaged, and untracked changes |
| `--commit <SHA>` | One commit's changes |

Match the flag to what the user actually wants reviewed. "Review my branch" is `--base`; "review what I have staged" is `--uncommitted`.

## Every scope flag conflicts with `[PROMPT]`

The usage line reads `codex review [OPTIONS] [PROMPT]`, which suggests you can pass custom instructions alongside a scope. You can't — all three scope flags are mutually exclusive with the positional prompt:

```
error: the argument '--base <BRANCH>' cannot be used with '[PROMPT]'
```

Verified through codex-cli 0.147.0. Take the scope flag: reviewing the correct diff matters more than steering the review. A bare `codex review "instructions"` is the only way to get custom instructions, and it gives up scope control to do it.

## Get the base branch right

Two ways to end up reviewing already-merged code, both of which waste a full run:

1. **Local branch refs go stale.** Use the remote ref (`origin/main`), never the local one (`main`) — local branches only move when you pull them.
2. **The remote ref is stale too, until you fetch.** Run `git fetch origin` first, every time.

Squash merges sharpen this: when a branch is cut from another branch that later gets squash-merged, the merged work reappears as unmerged commits in the diff, and the review fills up with findings about code that already landed.

```bash
git fetch origin
BASE=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null || echo origin/main)
```

If `origin/HEAD` isn't set — common in clones that never ran `git remote set-head` — that fallback is a guess. Confirm the real default branch with the user rather than reviewing against the wrong one.

## Run it in the background

It streams to stdout and runs for several minutes — well past the default Bash timeout — so run it with `run_in_background: true` rather than waiting on it. You'll be re-invoked when it exits, so there's no need to poll.

Redirect both streams into a file in your scratchpad directory so the transcript survives the wait:

```bash
codex review --base "$BASE" > "$OUT" 2>&1
```

Set `OUT` to a path under your scratchpad directory. Tell the user it's running before you go quiet — a silent multi-minute gap reads as a hang.

## Triage before relaying

Codex output is a starting point, not a verdict to pass through. Three things to check:

- **The `exec` blocks in the transcript are codex's own tool calls, not findings.** The actual verdict is at the end of the file.
- **Check the head it reviewed against current HEAD.** It reports what it reviewed. If commits landed after the run started, findings may already be fixed — this has produced a confident P1 about code that had been corrected two commits earlier.
- **Verify load-bearing claims against the tree yourself.** Observed failure mode: a type narrowing (`Array.isArray` on a union) reported as dead code when the TypeScript compiler actually requires it. Codex reads the diff, not the whole type graph.

Relay what survives that check, and say which findings you verified versus which you're passing along unchecked.
