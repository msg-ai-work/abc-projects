#!/usr/bin/env bash
set -euo pipefail
REF="${1:-}"
REPO="https://github.com/msg-ai-work/abc.git"
DEST=".ai-harness/common"
if [[ -z "$REF" ]]; then REF="$(awk '/^[[:space:]]*ref:/ {print $2; exit}' harness.yaml || true)"; REF="${REF:-main}"; fi
mkdir -p .ai-harness
if [[ -d "$DEST/.git" ]]; then git -C "$DEST" fetch --tags origin; else git clone "$REPO" "$DEST"; fi
git -C "$DEST" fetch --tags origin
if [[ "$REF" == "main" ]]; then git -C "$DEST" checkout main; git -C "$DEST" pull --ff-only origin main; else git -C "$DEST" checkout --detach "$REF"; fi
for p in "$DEST/HARNESS.md" "$DEST/.kiro/steering" "$DEST/.kiro/skills" ".kiro/agents/enterprise-messaging-projects.json"; do [[ -e "$p" ]] || { echo "Required Harness resource missing: $p" >&2; exit 1; }; done
echo "Common Harness ready: $REPO @ $REF"
echo 'Kiro Agent: enterprise-messaging-projects'
