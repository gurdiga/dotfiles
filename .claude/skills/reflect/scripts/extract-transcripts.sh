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

files=()
while IFS= read -r file; do
  files+=("$file")
done < <(find "$transcript_dir" -name "*.jsonl" -mtime "-$days" -type f 2>/dev/null)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No transcripts found from the past 7 days." >&2
  exit 0
fi

# Put the newest sessions first so the output cap preserves the most relevant
# work rather than whichever directory entries find happens to return first.
for ((i = 0; i < ${#files[@]}; i++)); do
  newest=$i
  for ((j = i + 1; j < ${#files[@]}; j++)); do
    if [[ "${files[$j]}" -nt "${files[$newest]}" ]]; then
      newest=$j
    fi
  done
  if ((newest != i)); then
    tmp=${files[$i]}
    files[i]=${files[newest]}
    files[newest]=$tmp
  fi
done

output_file=$(mktemp "${TMPDIR:-/tmp}/claude-reflect.XXXXXX")
trap 'rm -f "$output_file"' EXIT

jq -rn '
  def strip_tag($tag):
    gsub("<" + $tag + "[^>]*>[\\s\\S]*?</" + $tag + ">"; "");
  def clean:
    reduce [
      "ide_opened_file",
      "ide_selection",
      "command-message",
      "command-name",
      "system-reminder",
      "task-notification",
      "local-command-caveat",
      "local-command-stdout",
      "local-command-stderr"
    ][] as $tag (. ; strip_tag($tag))
    | gsub("^\\s+|\\s+$"; "");

  [ inputs |
    select((.isMeta // false) | not) |
    .message? as $message |
    select($message.role == "user" or $message.role == "assistant") |
    (if ($message.content | type) == "string" then $message.content
      elif ($message.content | type) == "array" then
        [$message.content[] | select(.type == "text") | (.text // "")] | join(" ")
      else "" end
    ) as $raw_text |
    ($raw_text | clean) as $text |
    select($text | length > 0) |
    "\($message.role | ascii_upcase): \($text)"
  ] | join("\n")
' "${files[@]}" > "$output_file"

head -c 40000 "$output_file"
