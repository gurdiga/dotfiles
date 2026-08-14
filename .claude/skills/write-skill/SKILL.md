---
name: write-skill
description: Create or improve a Claude Code Agent Skill (SKILL.md). Use when the user asks to capture a workflow as a skill, create a reusable skill, or turn something we just did together into a skill.
---

# Writing a Skill

## Storage

- Personal (all projects): `~/.claude/skills/<skill-name>/SKILL.md`
- Project-level: `.claude/skills/<skill-name>/SKILL.md`

## Structure

Every skill is a directory containing at minimum a `SKILL.md`:

```
skill-name/
├── SKILL.md          # required
├── scripts/          # optional: executable helpers
├── references/       # optional: reference docs loaded on demand
└── assets/           # optional: templates, static files
```

## SKILL.md format

```markdown
---
name: skill-name
description: What it does and when to trigger it. Be specific about
  trigger phrases — Claude tends to undertrigger, so be a little pushy:
  "Use this whenever the user mentions X, Y, or asks about Z."
---

# Skill Title

Instructions in imperative form. Explain the *why* behind each step,
not just the what — Claude is smart and works better with reasoning
than with rigid rules.
```

## Frontmatter reference

All fields are optional. `description` is strongly recommended.

| Field | Description |
|-------|-------------|
| `name` | Display name. Defaults to directory name. Lowercase, hyphens only, max 64 chars. |
| `description` | When to use the skill. Claude's primary trigger signal. |
| `when_to_use` | Extra trigger context appended to `description` in the skill listing. |
| `argument-hint` | Autocomplete hint, e.g. `[issue-number]` or `[filename] [format]`. |
| `arguments` | Named positional args for `$name` substitution (space-separated or YAML list). |
| `disable-model-invocation` | `true` = only user can invoke. Use for side-effectful workflows (deploy, commit, export). |
| `user-invocable` | `false` = hide from `/` menu. Use for background knowledge, not commands. |
| `allowed-tools` | Tools pre-approved without prompting, e.g. `Bash(git *) Read`. |
| `model` | Model override while this skill is active. |
| `effort` | Effort level override: `low`, `medium`, `high`, `xhigh`, `max`. |
| `context` | Set to `fork` to run in an isolated subagent context. |
| `agent` | Subagent type when `context: fork`: `Explore`, `Plan`, `general-purpose`, or a custom agent name. |
| `hooks` | Hooks scoped to this skill's lifecycle. |
| `paths` | Glob patterns limiting when the skill auto-activates (e.g. `src/**/*.ts`). |

### Invocation control

By default both user and Claude can invoke a skill. Two fields restrict this:

- **`disable-model-invocation: true`** — only the user can invoke (description hidden from Claude). Use for workflows with side effects: deploy, commit, send messages, export.
- **`user-invocable: false`** — only Claude can invoke (hidden from `/` menu). Use for background knowledge that isn't actionable as a command.

## Dynamic context injection

A SKILL.md can run shell commands at load time and substitute their output, so Claude sees live data rather than the command itself. Two forms:

- **Inline** — a bang followed by the command in single backticks, dropped into a line of prose or under a heading.
- **Block** — a fence opened with three backticks immediately followed by `!` (no language tag). Every line inside runs as one shell script, and the combined output replaces the block.

This section describes both forms in prose rather than showing them, on purpose. The loader scans for those literal sequences **anywhere** in the file — inside fenced code blocks and inside double-backtick escapes alike — so any example of the syntax executes as if it were real. An earlier version of this file documented the block form by example and aborted its own load; the inline example silently ran `git diff HEAD` on every load and pasted the result here.

A command that exits nonzero aborts the entire skill load, so guard anything that can fail — `cmd 2>/dev/null || echo "fallback"`.

## String substitutions

| Variable | Value |
|----------|-------|
| `$ARGUMENTS` | All arguments passed at invocation |
| `$ARGUMENTS[N]` or `$N` | Argument by 0-based index |
| `$name` | Named argument declared in `arguments` frontmatter |
| `${CLAUDE_SESSION_ID}` | Current session ID |
| `${CLAUDE_EFFORT}` | Current effort level |
| `${CLAUDE_SKILL_DIR}` | Directory containing this SKILL.md — use to reference bundled scripts portably |

Example using `${CLAUDE_SKILL_DIR}`:

```bash
python3 ${CLAUDE_SKILL_DIR}/scripts/analyze.py
```

## Writing guidelines

**Description** is the triggering mechanism — it's the only part always in context. Make it unambiguous about when to activate.

**Body** should be under 500 lines. If it grows beyond that, move reference material into `references/` files and link to them.

**Prefer explaining reasoning** over issuing mandates with MUST/NEVER. A model that understands why does better than one following rigid rules.

**Bundled scripts** are useful for deterministic, repetitive steps. They execute via Bash; only their output enters context, not their code. Reference them via `${CLAUDE_SKILL_DIR}/scripts/your-script.sh` so the path resolves correctly at any install level.

**Generalize** from the specific case that prompted the skill. The skill will be used in many different contexts, so avoid over-fitting to the example at hand.

## After writing

Tell the user where the skill was saved. Edits to existing skills take effect immediately (Claude Code watches skill directories for changes). New skill directories require restarting Claude Code to be picked up.
