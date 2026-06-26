# Remove the docs-drift-sync skill from ~/.claude (or $env:CLAUDE_CONFIG_DIR).
$ErrorActionPreference = 'Stop'
$claudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }
Remove-Item -Recurse -Force (Join-Path $claudeDir 'skills\docs-drift-sync') -ErrorAction SilentlyContinue
Write-Host "docs-drift-sync uninstalled from $claudeDir."
