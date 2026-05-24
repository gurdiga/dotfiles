#!/bin/bash
# Find the JSONL file for the current session (newest in project dir).
# Usage: find-session-jsonl.sh <project-path>
# Example: find-session-jsonl.sh /Users/vlad/src/my-project
#
# Prints the full path to the newest *.jsonl file.

PROJECT_PATH="${1:-$(pwd)}"

# Encode the project path: replace / with - (Claude's convention)
ENCODED=$(echo "$PROJECT_PATH" | sed 's|/|-|g')
PROJECT_DIR="$HOME/.claude/projects/$ENCODED"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "ERROR: Project directory not found: $PROJECT_DIR" >&2
  exit 1
fi

# Newest JSONL by modification time
NEWEST=$(ls -t "$PROJECT_DIR"/*.jsonl 2>/dev/null | head -1)

if [ -z "$NEWEST" ]; then
  echo "ERROR: No JSONL files found in $PROJECT_DIR" >&2
  exit 1
fi

echo "$NEWEST"
