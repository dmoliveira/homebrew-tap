#!/usr/bin/env bash
set -euo pipefail

SVG_PATH="docs/assets/homebrew-tap-hero.svg"
WEBP_PATH="docs/assets/homebrew-tap-hero.webp"
MAX_BYTES=524288

if [ ! -f "$SVG_PATH" ]; then
	echo "Missing SVG hero asset: $SVG_PATH"
	exit 1
fi

if [ ! -f "$WEBP_PATH" ]; then
	echo "Missing WebP hero asset: $WEBP_PATH"
	exit 1
fi

WEBP_SIZE=$(wc -c <"$WEBP_PATH")
if [ "$WEBP_SIZE" -le 0 ]; then
	echo "WebP hero asset is empty: $WEBP_PATH"
	exit 1
fi

if [ "$WEBP_SIZE" -gt "$MAX_BYTES" ]; then
	echo "WebP hero asset too large (${WEBP_SIZE} bytes). Limit is ${MAX_BYTES} bytes."
	exit 1
fi

python - "$WEBP_PATH" <<'PYIN'
import sys
from pathlib import Path

path = Path(sys.argv[1])
data = path.read_bytes()
if len(data) < 12:
    raise SystemExit(f"WebP file too small: {path}")
if data[0:4] != b"RIFF" or data[8:12] != b"WEBP":
    raise SystemExit(f"Invalid WebP header: {path}")
print(f"Hero asset check passed: {path}")
PYIN
