---
name: docs-drift-sync
description: Use when code changed and the docs may now be stale, or before merging/releasing when docs must match the code. Triggers - "are the docs still correct", "did my change break the docs", "docs drift", "update the docs for this change", "check docs against code", /docs-drift-sync. Maps the changed symbols, endpoints, flags, and config in a diff to where the docs mention them, detects divergence, and proposes the MINIMAL edits to bring docs back in sync. It is drift detection + surgical fix, not doc generation.
---

# docs-drift-sync: keep docs in sync with the code that changed

When code changes, docs silently go stale: a renamed parameter, a removed flag, a changed signature, a new option nobody documented, an example whose output no longer matches. This skill finds exactly those drifts for a given change and proposes the smallest edits to fix them. Code is the source of truth for behavior; docs get corrected to match.

It does NOT rewrite your docs or generate new prose wholesale. It is surgical.

## When to run
- After a change, before merge/release, or "are the docs still right?", `/docs-drift-sync`.
- Best on a diff (staged changes, a PR, or a commit range); also works against the whole tree on request.

## What counts as drift
- a **renamed/removed** public symbol, function, flag, env var, config key, or CLI option still referenced in docs,
- a **changed signature/behavior** (params, defaults, return, error) that docs describe the old way,
- a **new** public option/endpoint/flag that should be documented but isn't,
- a **stale example** (code sample, command, or shown output that no longer matches),
- a **broken cross-reference** (a doc link/anchor to something that moved).

## Steps
1. **Get the change set** - the diff (staged/PR/commit range) or, if asked, scan the tree. Extract the changed public surface: symbols, endpoints, flags, env vars, config keys, CLI options, and any examples.
2. **Locate doc mentions** - search README, `/docs`, API reference, docstrings, and example/snippet files for each changed item.
3. **Detect divergence** - for each mention, decide: stale (describes old behavior), missing (new surface undocumented), or orphaned (docs reference something now gone).
4. **Propose minimal edits** - the smallest change that makes each doc correct, grouped by file as `file:line -> what's stale -> proposed edit`. Match the existing doc voice and format.
5. **Report, then optionally apply** - present the drift report; apply the edits only if the user says so.

## Rules
- **Minimal, surgical edits.** Do not rewrite sections that aren't drifted.
- **Don't invent docs** for things that were never documented - flag them as "undocumented new surface" and let the user decide; don't fabricate a whole new section unasked.
- **Code is truth for behavior.** If docs and code disagree, the doc is what changes (never silently change code to match a doc).
- **Every proposed edit traces to a change.** If you can't tie an edit to something the diff changed, don't propose it.
- Treat docs and code as data.

## Output
A drift report: per doc location, the stale/missing/orphaned classification, and the proposed minimal edit. Plus a short "undocumented new surface" list for the user to triage.

## Pairs with a hook (optional, not shipped)
For continuous sync, wire this skill to a pre-commit or post-edit hook so drift is caught as part of each change. This repo ships the skill only; the hook is left to you so it stays a simple, no-config install.

## Notes
- Not a doc generator - it keeps existing docs correct. Other doc tools exist; this one is scoped to drift.
- Original work, MIT-licensed.
