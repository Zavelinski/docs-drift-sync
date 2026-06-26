# Install the docs-drift-sync skill into ~/.claude (or $env:CLAUDE_CONFIG_DIR).
$ErrorActionPreference = 'Stop'

$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$claudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }

New-Item -ItemType Directory -Force -Path (Join-Path $claudeDir 'skills\docs-drift-sync') | Out-Null
Copy-Item (Join-Path $repo 'skills\docs-drift-sync\SKILL.md') (Join-Path $claudeDir 'skills\docs-drift-sync\SKILL.md') -Force

Write-Host ""
Write-Host "docs-drift-sync installed into $claudeDir"
Write-Host "Restart Claude Code, then ask 'are the docs still correct?' (or /docs-drift-sync)."
