#!/usr/bin/env bash
# Install the docs-drift-sync skill into ~/.claude (or $CLAUDE_CONFIG_DIR).
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

mkdir -p "$claude_dir/skills/docs-drift-sync"
cp "$repo/skills/docs-drift-sync/SKILL.md" "$claude_dir/skills/docs-drift-sync/SKILL.md"

echo ""
echo "docs-drift-sync installed into $claude_dir"
echo "Restart Claude Code, then ask 'are the docs still correct?' (or /docs-drift-sync)."
