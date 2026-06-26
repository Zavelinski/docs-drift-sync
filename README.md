# docs-drift-sync for Claude Code

A [Claude Code](https://claude.com/claude-code) skill that **keeps docs in sync with the code that changed**. When you change code, docs silently go stale — a renamed parameter, a removed flag, a changed signature, an example whose output no longer matches. This maps the changed surface in a diff to where the docs mention it, detects the drift, and proposes the **minimal** edits to fix it.

It is drift detection + surgical fix — **not** a doc generator. It does not rewrite sections that didn't drift.

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

## Install

```bash
git clone https://github.com/Zavelinski/docs-drift-sync.git
cd docs-drift-sync
```

**macOS / Linux**
```bash
bash install.sh
```

**Windows (PowerShell)**
```powershell
.\install.ps1
```

Skill-only install (no hooks, no `settings.json` changes). Restart Claude Code, then ask **"are the docs still correct?"** (or `/docs-drift-sync`).

> For continuous sync you can wire this skill to a pre-commit or post-edit hook yourself. The repo ships the skill only, so the install stays simple and no-config.

## Uninstall

```bash
bash uninstall.sh      # macOS / Linux
```
```powershell
.\uninstall.ps1        # Windows
```

## License

MIT. See [LICENSE](LICENSE). Original work.
