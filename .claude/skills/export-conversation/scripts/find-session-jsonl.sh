#!/bin/bash
# Find the JSONL file for the current session (newest in project dir).
# Usage: find-session-jsonl.sh <project-path>
# Example: find-session-jsonl.sh /Users/vlad/src/my-project
#
# Prints the full path to the newest *.jsonl file.

PROJECT_PATH="${1:-$(pwd)}"

# Encode the project path: replace / with - (Claude's convention)
ENCODED=${PROJECT_PATH//\//-}
PROJECT_DIR="$HOME/.claude/projects/$ENCODED"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "ERROR: Project directory not found: $PROJECT_DIR" >&2
  exit 1
fi

# Newest JSONL by modification time. The NUL-delimited loop handles any
# characters that are valid in a filename.
NEWEST=""
while IFS= read -r -d '' candidate; do
  if [[ -z "$NEWEST" || "$candidate" -nt "$NEWEST" ]]; then
    NEWEST="$candidate"
  fi
done < <(find "$PROJECT_DIR" -maxdepth 1 -type f -name '*.jsonl' -print0 2>/dev/null)

if [ -z "$NEWEST" ]; then
  echo "ERROR: No JSONL files found in $PROJECT_DIR" >&2
  exit 1
fi

echo "$NEWEST"
