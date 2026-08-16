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

Where a repo has its own convention — a repo-local CLAUDE.md, or a house style plainly visible in `git log` — that wins. What follows is my default, measured over my own projects; don't impose it on a team repo.

Do not include the "🤖 Generated with [Claude Code](https://claude.com/claude-code)" footer in commit messages.

Include `Co-Authored-By: Claude <model> <noreply@anthropic.com>` as a trailer, naming the model that actually wrote the commit. GitHub squash merges silently drop these, so a trailerless commit on a default branch is not proof of unassisted authorship.

## Shape

- **Usually the subject line and nothing else.** Fewer than one commit in ten of mine has a body. Add one only when there is a *why* the diff cannot show. The trailer is not body prose.
- **Keep the subject near 30 characters.** Fifty is a ceiling nobody approaches, not a target.
- **Prefix with a scope and a colon** about half the time. The scope names whatever changed: a directory (`web-ui/shared:`), a container (`smtp-in:`), a function (`makeRssItem:`), a filename (`docker-compose.yml:`), a Make target (`make backup:`), or a feature by its display name. Nesting is fine: `delmon: heartbeat: add lineCountDiff`.
- **Lowercase after the scope.** `web-ui: no demoAccountNote`, not `web-ui: No demoAccountNote`.
- **Never end the subject with a period.**
- **Write a fragment, not a sentence.** Telegraphic noun phrases (`app: no NPM_VERSION`) and the literal command that was run (`npm i cheerio@latest`, `mv {parse,make}Date`) are as common as verb-initial subjects.

## Bodies, when there is one

- **Blank line after the subject, then a subordinate clause finishing the subject as one sentence.** `Because …` is the usual opener; `Otherwise …` gives the same construction from the failure side.
- **Rationale, never enumeration.** The subject says what changed; the body says why, or what breaks otherwise, or which obvious alternative was rejected. Don't list the files touched.
- **Prose, not bullets.** Pasted evidence — terminal output, error text — is exempt from this and from the wrap: introduce it with a line ending in a colon and paste it verbatim, unreflowed.
- **Wrap the body at 72 columns**, counting characters, not bytes — em dashes and curly quotes are multi-byte, so `wc -c` and macOS `awk` both overstate, and a byte-based reflow mangles lines that were already fine. The `commit-msg` hook in `git-hooks/` enforces this. To check a message by hand, which should print nothing:

  ```bash
  git log -1 --format=%B | perl -CSD -ne 'chomp; printf "%d: %s\n", length($_), $_ if length($_) > 72'
  ```

- **First person is normal.** This is a personal log, not a changelog entry.

## Vocabulary

- **Curly apostrophes; no em dashes.**
- **My idioms**: `intro X` for a new function or module (never "introduce"), `mv A B` for a rename, `no X` for a removal, `sketch` for exploratory work, `tweak` for a small adjustment, a `(2)`/`(3)` suffix for a fix that needed retrying.
- **No Conventional Commits, no `[bracket]` prefixes, no changelog verbs** (`refactor`, `chore`, `feat`, `implement`, `enhance`, `ensure`) — in my own projects; team repos may require exactly these.
- **Don't reach for `Housekeeping`.** A dead habit of mine that still litters my older history.

## Examples

The modal commit — a scoped, lowercase subject and nothing else:

```
logrotate: dateext

Co-Authored-By: Claude <model> <noreply@anthropic.com>
```

The rare body, in full:

```
make certbot-report update

Because logs are now rotated monthly.

Co-Authored-By: Claude <model> <noreply@anthropic.com>
```

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
