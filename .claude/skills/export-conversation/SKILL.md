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

### 2. Parse and extract via agent

Spawn a general-purpose agent to read and parse the JSONL. Each line is a JSON object. The agent should extract:

- `timestamp` — ISO 8601 string from the top-level `timestamp` field
- `role` — from `message.role` (`"user"` or `"assistant"`)
- Text content — from `message.content`, which is either a string or an array of content blocks. Extract `type: "text"` blocks only. For `type: "tool_use"` blocks, emit a brief inline note like `[tool: ToolName]` rather than skipping silently. For `type: "tool_result"` blocks, skip entirely (they're noise).

Instruct the agent to output messages in this format:

```
## [<timestamp>] <role>

<text>

---
```

Skip turns that contain only tool use with no text (common for intermediate assistant steps). Preserve interrupted user turns (marked `[Request interrupted by user]`) — they're useful context.

### 3. Write the output

Write the extracted conversation to the file the user specified (default: `./conversation.md`). Add a `# Conversation` heading at the top.

## Notes

- The JSONL grows during the session. Running this early yields a partial export — that's fine, just note it if relevant.
- The newest `.jsonl` is used as a proxy for "current session." This is reliable as long as you run the script promptly; a new session started in another window would produce a newer file.
- Agent tool results embedded in the conversation (large code dumps, file contents) should be omitted — they're derivable from the codebase and bloat the export.
