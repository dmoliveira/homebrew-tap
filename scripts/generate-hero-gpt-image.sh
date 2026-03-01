#!/usr/bin/env bash
set -euo pipefail

if [ -z "${OPENAI_API_KEY:-}" ]; then
	echo "OPENAI_API_KEY is required to generate the hero image."
	exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROMPT_FILE="$ROOT_DIR/docs/assets/gpt-image-1.5-prompt.md"
OUTPUT_WEBP="$ROOT_DIR/docs/assets/homebrew-tap-hero.webp"
OUTPUT_JSON="$ROOT_DIR/docs/assets/gpt-image-response.json"
IMAGE_MODEL="${OPENAI_IMAGE_MODEL:-gpt-image-1.5}"

PROMPT="$(
	python - "$PROMPT_FILE" <<'PYIN'
from pathlib import Path
import sys
text = Path(sys.argv[1]).read_text()
parts = text.split('## Prompt', 1)
if len(parts) < 2:
    raise SystemExit('Prompt section not found')
print(parts[1].strip())
PYIN
)"

PAYLOAD="$(
	python - "$IMAGE_MODEL" "$PROMPT" <<'PYIN'
import json
import sys
model = sys.argv[1]
prompt = sys.argv[2]
print(json.dumps({
  'model': model,
  'prompt': prompt,
  'size': '1536x1024',
  'background': 'opaque',
  'output_format': 'webp'
}))
PYIN
)"

curl -fsSL https://api.openai.com/v1/images/generations \
	-H "Authorization: Bearer $OPENAI_API_KEY" \
	-H "Content-Type: application/json" \
	-d "$PAYLOAD" >"$OUTPUT_JSON"

python - "$OUTPUT_JSON" "$OUTPUT_WEBP" <<'PYIN'
import base64
import json
import sys
from pathlib import Path
response_path = Path(sys.argv[1])
out_path = Path(sys.argv[2])
response = json.loads(response_path.read_text())
image_b64 = response['data'][0]['b64_json']
out_path.write_bytes(base64.b64decode(image_b64))
print(f'Generated {out_path}')
PYIN
