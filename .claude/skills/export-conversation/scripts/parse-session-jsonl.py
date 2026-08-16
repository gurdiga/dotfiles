#!/usr/bin/env python3
"""Parse a Claude Code session JSONL and write a conversation markdown file.

Usage: parse-session-jsonl.py <session.jsonl> <output.md> [--from HH:MM:SS] [--until HH:MM:SS]
"""

import argparse
import json
import re
import sys
from datetime import datetime


def tool_note(block):
    name = block.get("name", "")
    inp = block.get("input", {})
    if name == "Bash":
        cmd = inp.get("command", "").strip().replace("\n", " ")
        if len(cmd) > 120:
            cmd = cmd[:117] + "..."
        return f"Bash: `{cmd}`"
    if name in ("Read", "Write", "Edit"):
        path = inp.get("file_path", "")
        return f"{name}: `{path}`"
    if name == "Skill":
        skill = inp.get("skill", "")
        return f"Skill: `{skill}`"
    return f"{name}"


STRIP_TAGS = re.compile(r"<(ide_opened_file|ide_selection|command-message|command-name|system-reminder)[^>]*>.*?</\1>", re.DOTALL)


def clean(text):
    return STRIP_TAGS.sub("", text).strip()


def extract_turn(message):
    content = message.get("content", "")
    if isinstance(content, str):
        return clean(content), False

    parts = []
    has_text = False
    for block in content:
        t = block.get("type")
        if t == "text":
            text = clean(block.get("text", ""))
            if text:
                parts.append(text)
                has_text = True
        elif t == "tool_use":
            parts.append(tool_note(block))
        # tool_result: skip

    return "\n\n".join(parts), has_text


def parse_time(s):
    return datetime.strptime(s, "%H:%M:%S").time()


def main():
    parser = argparse.ArgumentParser(
        description="Export Claude session JSONL to markdown."
    )
    parser.add_argument("jsonl", help="Path to session .jsonl file")
    parser.add_argument("output", help="Path to output .md file")
    parser.add_argument(
        "--from",
        dest="from_time",
        metavar="HH:MM:SS",
        type=parse_time,
        help="Include messages at or after this local time",
    )
    parser.add_argument(
        "--until",
        metavar="HH:MM:SS",
        type=parse_time,
        help="Include messages at or before this local time",
    )
    args = parser.parse_args()

    turns = []

    with open(args.jsonl, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            data = json.loads(line)
            message = data.get("message", {})
            role = message.get("role")
            if role not in ("user", "assistant"):
                continue
            timestamp = data.get("timestamp", "")
            text, has_text = extract_turn(message)
            if not text:
                continue
            if text.startswith("Base directory for this skill:"):
                continue

            try:
                dt = datetime.fromisoformat(timestamp.replace("Z", "+00:00")).astimezone()
                local_time = dt.time().replace(tzinfo=None)
                if args.from_time and local_time < args.from_time:
                    continue
                if args.until and local_time > args.until:
                    continue
                friendly = dt.strftime("%H:%M:%S")
            except Exception:
                friendly = timestamp

            turns.append((friendly, role, text))

    with open(args.output, "w", encoding="utf-8") as f:
        f.write("# Conversation\n")
        for friendly, role, text in turns:
            f.write(f"\n## {role}\n\n*{friendly}*\n\n{text}\n\n---\n")

    print(f"Wrote {len(turns)} turns to {args.output}")


if __name__ == "__main__":
    main()
