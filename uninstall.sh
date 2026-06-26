#!/usr/bin/env bash
# Remove the docs-drift-sync skill from ~/.claude (or $CLAUDE_CONFIG_DIR).
set -euo pipefail
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
rm -rf "$claude_dir/skills/docs-drift-sync"
echo "docs-drift-sync uninstalled from $claude_dir."
