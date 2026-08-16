#!/bin/bash
# Extracts human/assistant turns from recent transcripts for the current
# project. Accepts an optional number of days (default: 30). Outputs plain
# text capped at 40 KB.
set -euo pipefail

days="${1:-30}"
project_path=$(pwd)
encoded=${project_path//\//-}
transcript_dir="$HOME/.claude/projects/$encoded"

[[ -d "$transcript_dir" ]] || { echo "No transcript directory found for this project." >&2; exit 1; }

mapfile -t files < <(find "$transcript_dir" -name "*.jsonl" -mtime -"$days" -type f 2>/dev/null)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No transcripts found from the past 7 days." >&2
  exit 0
fi

jq -rn '
  [ inputs |
    select(.role == "user" or .role == "assistant") |
    "\(.role | ascii_upcase): \(
      if (.content | type) == "string" then .content
      elif (.content | type) == "array" then
        [.content[] | select(.type == "text") | .text] | join(" ")
      else "" end
    )"
  ] | join("\n")
' "${files[@]}" | head -c 40000
