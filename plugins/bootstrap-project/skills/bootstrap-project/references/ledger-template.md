# <PROJECT>-LEDGER.md template

This is the plan index — it answers "what's the current sequence of
implementation work, and why is it ordered this way." It is not a status
dashboard generated after the fact; it's read *first*, before starting or
resuming any plan, so it has to actually orient a cold-start reader.

Write the file at `docs/superpowers/plans/<PROJECT>-LEDGER.md` with this
shape:

```markdown
# <Project Name> — Plan Ledger

> **Read this first** before writing, executing, or continuing any
> implementation plan. Keep it updated: when a plan ships, move it to
> "Shipped" with its PR or commit; when a new plan is written, add it
> here with a status.

**Project:** <one line: what it is, who it's for>. Repo:
`<github url>`. Local path: `<absolute path, especially if it could be
ambiguous — a synced folder, multiple checkouts>`. <Prod URL if one
exists.>

Plans/specs live in `docs/superpowers/plans/` and `docs/superpowers/specs/`.
Memory is backed up under `docs/claude-memory/`. See `CLAUDE.md` for
stack/decisions already locked in.

---

## Sequencing principle

<One paragraph, in prose, on WHY work is ordered the way the table below
orders it — not just that it is. E.g.: "nothing that guards or repairs
the codebase gets built on top of something unverified" or "the schema
migration goes first because everything else reads from the new shape."
A table with no rationale above it is just a to-do list; the rationale
is what makes it a *sequence*.>

## Phase 1 — <name>

*(example row — delete once real phases exist; do not leave this row,
its `<short-sha>`, or the "Phase 1" header sitting in a real project's
ledger)*

| Item | Evidence | State |
|---|---|---|
| <task, done example> | `src/foo.ts:42` implements the thing; see PR #N | ✅ DONE `<short-sha>` |

<!-- Real phases start here. Add them as work is actually planned — don't
pre-populate phases you're guessing at; a ledger with NO Phase section
yet, plus this sequencing-principle paragraph, is the correct state for
a brand-new project. An empty-but-honest ledger beats a fully-imagined
one that's wrong by week two. -->
```

## The rule that keeps this file trustworthy

Every "done" entry cites something checkable — a commit hash, a PR
number, a file and line. A checkmark with no evidence is indistinguishable
from a checkmark that's wrong, and six months from now nobody (human or
agent) can tell the difference without re-doing the work. The one-line
cost per row buys back that entire re-verification.
