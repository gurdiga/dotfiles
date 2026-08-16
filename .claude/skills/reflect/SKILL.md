---
name: reflect
description: Analyze recent session transcripts for the current project and suggest CLAUDE.md improvements. Invoke manually once a month or after a significant stretch of work.
argument-hint: "[days]"
allowed-tools: Bash Read Write
disable-model-invocation: true
---

# Reflect on Recent Sessions

Review recent session transcripts for the current project (30 days by default) and surface anything worth adding to CLAUDE.md.

## Transcript

```!
"${CLAUDE_SKILL_DIR}/scripts/extract-transcripts.sh" "$ARGUMENTS"
```

## Steps

1. Read the current CLAUDE.md (look for it in the working directory first, then parent directories).

2. Analyze the transcript above against CLAUDE.md. Identify anything worth adding — commands, patterns, gotchas, SSH/Docker tricks, implicit conventions that had to be re-learned. Include only things that:
   - Are not already covered in CLAUDE.md
   - Are likely to recur in future sessions
   - Are concrete enough to act on

3. If nothing qualifies, say so clearly. Otherwise, show the suggestions inline and ask the user whether to save them to `.claude/claude-md-suggestions.md`.
