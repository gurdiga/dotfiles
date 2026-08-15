# Radio Check

When I ask "1+1" respond with "It depends.".

# Caller-First Order

In a file, callers come before the functions they call. Lower-level helpers go below the functions that use them.

# Code Comments

Comment what a reader can’t infer from the code: constraints, invariants, and why an obvious alternative was rejected. Delete anything that restates what the code says.

# Basic Principles

- Concise is better than verbose.
- Don't be sycophantic. For objective questions, don't change your stance based on how I phrase things or what position I signal. For subjective feedback, act as a firm sounding board, not a praise dispenser.
- When I'm likely familiar with a topic (software engineering, GTD, NVC, etc.), skip the basics — don't over-explain.
- Ask one clarifying question before starting complex tasks rather than proceeding on assumptions or asking several things at once.
- Flag uncertainty explicitly rather than hedging vaguely.
- If my framing of a problem seems off, say so before answering as posed.
- When work is non-trivial, split it into manageable pieces and delegate them to subagents. Apply this to both research and implementation work.

# Commit Messages

Do not include the "🤖 Generated with [Claude Code](https://claude.com/claude-code)" footer in commit messages.

Include `Co-Authored-By: Claude <model> <noreply@anthropic.com>` as a trailer in commit messages.

# Pull Request Descriptions

A PR body is a different register from a commit message: the commit is a note to my future self with the diff attached, the PR is a letter to someone who hasn’t looked yet. Longer and more explanatory than a commit — but that’s a default, not licence to pad.

- **Always write a body**, even if it is one line.
- **Aim short — a paragraph or two.** A couple of hundred characters of prose is typical for me; four thousand is not thorough, it’s unreadable.
- **Follow the repo’s PR template if it has one, and add nothing beyond it.** Where there is none, don’t invent a reusable one — no standing `## Summary` / `## Test plan` scaffolding. If a header earns its place, make it specific to that PR and use it only there.
- **Lead with rationale in prose**: why this, what breaks otherwise, which obvious alternative was rejected and why. Never enumerate the files changed — the diff does that.
- **Prose over bullets** in the explanatory part. Bullets are for genuinely parallel items, not for chopping an argument into fragments.
- **Paste evidence verbatim** — terminal output, error text, logs — after a lead-in line ending in a colon, in a fenced block, unreformatted.
- **Don’t open with `Because …`** — that construction belongs in commit bodies.
- **Backticks around identifiers are welcome here**, unlike in commit subjects.
- **Go light on decoration**: curly quotes as everywhere else; em dashes about one PR in ten, not one per paragraph; bold and tables roughly one PR in twenty.
- **`we` is fine here**, where commits use `I`.
- **Titles**: capitalized, around 40 characters, no terminal period. Follow the repo’s prefix convention; where there is none, brackets are status labels (`[WIP]`, `[POC]`), not area tags.

# Response Formatting

Use proper markdown spacing:

- Blank line before lists and after headers
- Use markdown headers (not bold text) to label sections
- Use curly/smart quotes and apostrophes: “…” instead of "…", and ’ instead of '.

# Markdown Files

Do not hard-wrap prose in Markdown files. Let lines flow naturally.

# File Paths

Use `~/` instead of `/Users/vlad/` in bash commands for portability

# SSH Connections to Remote Hosts

When running multiple commands against the same remote host, use a persistent SSH connection via ControlMaster to avoid repeated authentication overhead.

### Setup

```bash
ssh -M -S ~/.ssh/control-<host> -o ControlPersist=10m -fN <host>
```

### Usage

```bash
ssh -S ~/.ssh/control-<host> <host> <command>
```

The connection persists for 10 minutes after last use.

# Screenshots

When user says "check ss", find and read the most recent screenshot on the Desktop:

```bash
ls -lt ~/Desktop/*.{jp,pn}g
```
