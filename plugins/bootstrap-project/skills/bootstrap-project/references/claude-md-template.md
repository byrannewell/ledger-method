# CLAUDE.md template

Fill every `<...>` placeholder. The template below imports only
`AGENTS.md` — if this project later grows its own load-bearing reference
doc (a data-access-patterns doc, a design-system doc, anything you'd want
read before every plan), add it as its own `@path/to/doc.md` line under
`@AGENTS.md`. Don't add an import for a doc that doesn't exist yet; an
import to a missing file is worse than no import.

```
@AGENTS.md

# <Project name>

<One or two sentences: what this ships and for whom.> See the full
brainstorming spec at `docs/superpowers/specs/<date>-<project>-design.md`
once one exists.

## Starting new plan work

Always read `docs/superpowers/plans/<PROJECT>-LEDGER.md` FIRST when
beginning any implementation plan — it has the phase decomposition,
current status, and pointers to every spec and plan file. Then read the
most recent completed plan for continuity patterns.

To write a new plan: invoke `superpowers:writing-plans`. Save it at
`~/.claude/plans/<date>-<slug>.md`. Update the ledger with the new
filename and status.

To execute a plan: invoke `superpowers:subagent-driven-development` (or
inline execution for simple mechanical tasks).

## Key decisions already locked in (don't re-litigate)

- <Stack, one line per irreversible choice — framework, database, auth
  model, payments provider, hosting.>
- <Anything with a known-bad alternative someone will suggest again:
  name the alternative and why it's closed.>

## Pointers

- Brainstorming spec: `docs/superpowers/specs/...` (once written)
- Plan ledger: `docs/superpowers/plans/<PROJECT>-LEDGER.md`
- GitHub: <repo url>

## Local env quirks

- <Anything a fresh machine will hit and lose an hour to. Name the fix,
  not just the symptom — "don't debug this, do X" beats a bug report.>
```

## Why each section exists

- **The import line** pulls framework-specific gotchas in without bloating
  this file — see `agents-md-template.md`.
- **"Starting new plan work"** is the single most load-bearing paragraph
  in the whole file: it's what makes a cold-start agent go read the ledger
  before doing anything, instead of guessing at project state from the
  code alone.
- **"Don't re-litigate"** exists because the same alternative gets
  re-suggested by a fresh agent (or a fresh session) that has no memory of
  why it was rejected. Naming the rejected alternative, not just the
  choice, is what actually stops the re-litigation. If the person you're
  interviewing hasn't told you what alternative was considered or why —
  don't invent a plausible-sounding justification to fill the line. Write
  down the choice plainly and say the rejection reasoning isn't recorded
  yet; a made-up rationale that sounds authoritative is worse than an
  honest gap, because nobody will think to question it later.
- **"Local env quirks"** is for the one-hour sinkholes — an arm64 Docker
  image bug, a dev server that hangs on a specific port — where the fix
  is empirically known but re-discovering it from scratch is expensive.
