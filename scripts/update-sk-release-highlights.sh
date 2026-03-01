#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

COUNT="${1:-3}"
SOURCE_REPO="${SK_RELEASE_SOURCE_REPO:-dmoliveira/sk}"
README_PATH="${SK_RELEASE_HIGHLIGHTS_README:-README.md}"
START_MARKER="<!-- sk-release-highlights:start -->"
END_MARKER="<!-- sk-release-highlights:end -->"

if ! command -v gh >/dev/null 2>&1; then
	printf 'Error: gh CLI is required\n' >&2
	exit 1
fi

if [[ ! "$COUNT" =~ ^[0-9]+$ ]] || [[ "$COUNT" -lt 1 ]]; then
	printf 'Error: count must be a positive integer\n' >&2
	exit 1
fi

if [[ ! -f "$README_PATH" ]]; then
	printf 'Error: README not found at %s\n' "$README_PATH" >&2
	exit 1
fi

python - "$SOURCE_REPO" "$COUNT" "$README_PATH" "$START_MARKER" "$END_MARKER" <<'PYCODE'
import json
import re
import subprocess
import sys
from datetime import datetime
from pathlib import Path

repo = sys.argv[1]
count = int(sys.argv[2])
readme_path = Path(sys.argv[3])
start_marker = sys.argv[4]
end_marker = sys.argv[5]

releases_raw = subprocess.check_output(
    ["gh", "api", f"repos/{repo}/releases?per_page={count}"],
    text=True,
)
releases = json.loads(releases_raw)
filtered = [r for r in releases if not r.get("draft") and not r.get("prerelease")]
deduped = []
seen_tags = set()
for release in filtered:
    tag = release.get("tag_name")
    if not tag or tag in seen_tags:
        continue
    seen_tags.add(tag)
    deduped.append(release)
releases = deduped[:count]

if not releases:
    raise SystemExit("No releases found")

lines = [start_marker, ""]
for release in releases:
    tag = release["tag_name"]
    title = (release.get("name") or tag).strip()
    published = release.get("published_at")
    date_text = ""
    if published:
        date_text = datetime.fromisoformat(published.replace("Z", "+00:00")).strftime("%Y-%m-%d")
    summary = f"{title}"
    if date_text:
        summary = f"{summary} ({date_text})"

    pr_line = None
    try:
        commit_raw = subprocess.check_output(["gh", "api", f"repos/{repo}/commits/{tag}"], text=True)
        message = json.loads(commit_raw).get("commit", {}).get("message", "")
        match = re.search(r"Merge pull request #(\d+)", message)
        if match:
            pr_line = f"  - PR: `https://github.com/{repo}/pull/{match.group(1)}`"
    except subprocess.CalledProcessError:
        pr_line = None

    lines.append(f"- `{tag}`: {summary}")
    lines.append(f"  - Tag: `{release['html_url']}`")
    if pr_line:
        lines.append(pr_line)

lines.extend(["", end_marker])
rendered = "\n".join(lines)

readme = readme_path.read_text()
if start_marker not in readme or end_marker not in readme:
    raise SystemExit(f"Missing markers in {readme_path}")

start_index = readme.index(start_marker)
end_index = readme.index(end_marker) + len(end_marker)
updated = readme[:start_index] + rendered + readme[end_index:]
readme_path.write_text(updated)
PYCODE

printf 'Updated sk release highlights in %s\n' "$README_PATH"
