---
name: export-conversation
description: >
  Export the current conversation to a markdown file. Use this whenever
  the user asks to "export", "save", or "write" the conversation to a
  file, or says something like "export this conversation to X.md".
disable-model-invocation: true
---

# Export Conversation

Export the current Claude Code session as a readable markdown file.

## Steps

### 1. Find the session JSONL

Run the bundled script to locate the current session file:

```bash
${CLAUDE_SKILL_DIR}/scripts/find-session-jsonl.sh <project-path>
```

Where `<project-path>` is the working directory (e.g. `/Users/vlad/src/my-project`). It prints the path to the newest `.jsonl` in the project's Claude storage directory — which is the current session.

### 2. Parse and extract

Run the bundled script:

```bash
python3 ${CLAUDE_SKILL_DIR}/scripts/parse-session-jsonl.py <session.jsonl> <output.md> [--from HH:MM:SS] [--until HH:MM:SS]
```

The script writes `# Conversation` followed by one section per turn. Each section header shows the role and a human-friendly local time as a subdued subtitle (`## user <sub>2:17 pm</sub>`). Tool calls are inlined as brief notes — Bash includes the command, Read/Write/Edit include the file path. Assistant turns that are only tool calls with no prose are omitted.

## Notes

- The JSONL grows during the session. Running this early yields a partial export — that's fine, just note it if relevant.
- The newest `.jsonl` is used as a proxy for "current session." This is reliable as long as you run the script promptly; a new session started in another window would produce a newer file.
- Agent tool results embedded in the conversation (large code dumps, file contents) should be omitted — they're derivable from the codebase and bloat the export.
