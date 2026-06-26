# docs-drift-sync for Claude Code

[![License: MIT](https://img.shields.io/github/license/Zavelinski/claude-code-docs-drift-sync)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Zavelinski/claude-code-docs-drift-sync?style=flat)](https://github.com/Zavelinski/claude-code-docs-drift-sync/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Zavelinski/claude-code-docs-drift-sync)](https://github.com/Zavelinski/claude-code-docs-drift-sync/commits)
[![Claude Code skill](https://img.shields.io/badge/Claude%20Code-skill-8A2BE2)](https://claude.com/claude-code)

A [Claude Code](https://claude.com/claude-code) skill that **keeps docs in sync with the code that changed**. When you change code, docs silently go stale — a renamed parameter, a removed flag, a changed signature, an example whose output no longer matches. This maps the changed surface in a diff to where the docs mention it, detects the drift, and proposes the **minimal** edits to fix it.

It is drift detection + surgical fix — **not** a doc generator. It does not rewrite sections that didn't drift.

## Prerequisites

Claude Code with `/plugin` support (v2.x+) and a shell if you use the manual fallback.

## Install

### Option 1 — Claude Code plugin marketplace (recommended)

```bash
/plugin marketplace add Zavelinski/claude-code-skills
/plugin install docs-drift-sync@claude-code-skills
```

Registered hooks (if any) install through the Claude Code consent UI, with no manual edit to `~/.claude/settings.json`.

### Option 2 — Manual fallback (run it yourself)

> **Security note.** This script mutates `~/.claude/settings.json` directly. Claude Code auto-mode blocks it because a third-party `UserPromptSubmit` hook that injects text into every prompt is a known risk vector. The script is benign and local-only (no network), but you must review and run it yourself. Prefer Option 1.

```bash
git clone https://github.com/Zavelinski/claude-code-docs-drift-sync.git
cd claude-code-docs-drift-sync
bash install.sh        # macOS / Linux
.\install.ps1          # Windows (PowerShell)
```

## Uninstall

```bash
/plugin uninstall docs-drift-sync@claude-code-skills    # Option 1
bash uninstall.sh                                # Option 2 (or uninstall.ps1 on Windows)
```

## Update

```bash
/plugin marketplace update claude-code-skills    # Option 1
# Option 2: pull the latest commit and re-run the manual fallback.
```

## What counts as drift

- a renamed/removed symbol, flag, env var, config key, or CLI option still referenced in docs,
- a changed signature/behavior (params, defaults, return, error) described the old way,
- a new public option/endpoint/flag that should be documented but isn't,
- a stale example (sample, command, or shown output that no longer matches),
- a broken cross-reference to something that moved.

## How it works

1. **Get the change set** — a diff (staged / PR / commit range) or the whole tree on request — and extract the changed public surface.
2. **Locate doc mentions** across README, `/docs`, API reference, docstrings, and examples.
3. **Detect divergence** — stale / missing / orphaned.
4. **Propose minimal edits** — `file:line → what's stale → proposed edit`, in your docs' existing voice.
5. **Report, then optionally apply.**

### Rules it follows
- Minimal, surgical edits — nothing rewritten that wasn't drifted.
- Won't invent docs for things that were never documented — it flags them for you to decide.
- Code is the source of truth for behavior; docs change to match, never the reverse.
- Every proposed edit traces to something the diff changed.

## License

MIT. See [LICENSE](LICENSE). Original work.

---

## Part of claude-code-skills

This skill ships in the [claude-code-skills](https://zavelinski.github.io/claude-code-skills/) marketplace. Browse its landing page: [docs-drift-sync](https://zavelinski.github.io/claude-code-skills/docs-drift-sync.html). See also: [scheduled-sop-runner](https://github.com/Zavelinski/claude-code-scheduled-sop-runner), [geo-aeo-audit](https://github.com/Zavelinski/claude-code-geo-aeo-audit).