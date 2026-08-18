---
name: bootstrap-project
description: Bootstraps a brand-new software project with the Ledger Method — a spec-driven-development discipline (root-cause before fix, plan before code, evidence before claims, tiered deferred-work tracking) battle-tested on a production app. Use this whenever someone is starting a new repo and wants it "set up properly," wants the same process used on another of their projects, mentions wanting a plan ledger or a rev-tracker for a new codebase, asks to scaffold CLAUDE.md conventions or a memory-backup hook, or says something like "set this repo up the same way as my other project" where that other project uses this method. Trigger even if they don't name any of this by these exact terms — "I want good process from day one on this new app" or "make sure future-me doesn't lose track of decisions on this repo" both mean this skill.
---

# Bootstrap Project (Ledger Method)

This skill sets up how work gets *tracked and remembered* on a new
project. It does not write application code, choose a stack, or install
dependencies — those are the user's calls, made once during the
interview below and then respected.

It rests on three layers, and this skill only builds one of them:

1. **Discipline** — an installed plugin stack (brainstorm → plan → build
   → verify → ship). Not authored here; Step 0 just makes sure it's on.
2. **Scaffolding** — `CLAUDE.md`, a `docs/` tree, two tracker files, a
   backup hook. This is what this skill actually creates. Steps 1-5.
3. **Memory** — behavior, not a file to create. Nothing to do here beyond
   wiring the backup hook in Step 5.

Work through the steps below in order — each one depends on decisions
made in the step before it.

## Step 0 — Confirm the discipline layer is on

Read `~/.claude/settings.json` and check its `enabledPlugins` map. The
eight plugins below are domain-agnostic — they carry the actual
process discipline and belong on regardless of what this new project is:

`superpowers`, `remember`, `skill-creator`, `claude-md-management`,
`frontend-design`, `feature-dev`, `code-simplifier`, `context7`

For any missing, add `"<name>@claude-plugins-official": true` to
`enabledPlugins` and tell the user which ones you turned on — scaffolding
without this layer is just folders; the workflow discipline is what makes
the folders get used correctly. Don't enable stack-specific plugins
(a hosting provider, a payments processor, a database vendor) on your
own judgment — ask, since those depend on what this project's stack
actually is, decided in the next step.

## Step 1 — Interview

Ask only what genuinely can't be inferred from the conversation or an
existing README/package.json:

- Project name and a one-sentence description
- Repo URL, if one exists yet
- 3-5 decisions worth locking in now — framework, database, auth model,
  hosting, payments — specifically the ones where someone (including a
  future session with no memory of this conversation) will suggest the
  rejected alternative again. Naming the alternative and why it's closed
  is what actually prevents the re-litigation; the choice alone doesn't.
- The trunk branch name (usually `main`)

Confirm what you've gathered before writing anything — a wrong project
name baked into five files is more annoying to fix than a five-second
confirmation up front.

## Step 2 — Write CLAUDE.md and AGENTS.md

Fill in `references/claude-md-template.md` and
`references/agents-md-template.md` with what Step 1 produced, and write
them to the repo root. Read the "why each section exists" notes at the
bottom of each template before filling them in blind — a couple of the
sections (especially "Starting new plan work" in CLAUDE.md) need to stay
close to verbatim to do their job.

## Step 3 — Scaffold docs/

Create the tree described in `references/docs-tree-readme.md`
(`docs/superpowers/{plans,specs,refs}`, `docs/claude-memory/`,
`docs/runbooks/`, `docs/findings/`), including the
`docs/claude-memory/README.md` it specifies. Git doesn't track empty
directories, so drop a `.gitkeep` in any folder that has nothing else in
it yet (`docs/superpowers/refs/`, `docs/runbooks/`, `docs/findings/` at
minimum) — otherwise "scaffold the tree" doesn't survive being committed.
Tell the user what each folder is for in your summary — an empty folder
with no explanation just looks like scaffolding for its own sake.

Once Steps 2-5 are all done, commit everything this skill created
(`CLAUDE.md`, `AGENTS.md`, `docs/`, `scripts/backup-claude-state.sh`,
`.claude/settings.json`) in one commit. The whole point of this layer is
that it's git-tracked, not sitting only in the working tree — an
uncommitted scaffold is exactly as loseable as no scaffold at all.

## Step 4 — Create the two tracker files

Write `docs/superpowers/plans/<PROJECT>-LEDGER.md` from
`references/ledger-template.md` and
`docs/superpowers/plans/<PROJECT>-REV-TRACKER.md` from
`references/rev-tracker-template.md`, substituting the project name
throughout. Delete the ledger template's example phase/row (it's marked
"delete once real phases exist" for exactly this reason) and leave the
rev-tracker's tier tables genuinely empty — don't invent phases, rows,
commit shas, or defer imaginary work to make either file look more
finished. These earn their content from real work; a bootstrap step
guessing at the future is worse than an honest empty table.

## Step 5 — Wire the backup hook

Take `references/backup-hook-template.sh`, replace `<<REPO_PATH>>` with
this repo's absolute path, `<<MEMORY_DIR>>` with the memory directory
Claude Code is using for this project (check the auto-memory system
prompt section, or `~/.claude/projects/<encoded-cwd>/memory/` if that's
not visible), and `<<TRUNK_BRANCH>>` with the branch name from Step 1.
Both substituted paths sit inside double-quoted bash assignments in the
script, where a leading `~` does **not** expand — write the full
absolute path (e.g. `/Users/name/...`), never a literal `~`, or the
memory-mirror step will silently no-op forever. Write the result to
`scripts/backup-claude-state.sh` and `chmod +x` it.

Then add it to **this project's own** `.claude/settings.json` (create the
file if it doesn't exist yet) under `hooks.Stop` — project-scoped, so the
hook travels with the repo in git instead of silently mutating the user's
global, machine-wide Claude Code config:

```json
{
  "hooks": {
    "Stop": [
      { "hooks": [ { "type": "command", "command": "bash scripts/backup-claude-state.sh" } ] }
    ]
  }
}
```

If `.claude/settings.json` already has other content, merge into it —
don't overwrite existing hooks or settings.

## Step 6 — Report, and be explicit about what you didn't do

Give a short checklist of what got created. Then, separately and just as
visibly, name what you deliberately left alone:

- **Branch protection on the trunk branch.** This changes what anyone —
  including a future session — can push straight to, it needs repo-admin
  access, and it's exactly the kind of external, not-easily-reversed
  change that deserves a plain-language confirmation before it happens
  rather than after. Describe the policy you'd set (PR required,
  squash-only merges, no bypass actors) and ask before touching it.
- **Any actual code, dependencies, or infrastructure.** This skill sets
  up how work gets tracked and remembered — not the project itself.

## Why this shape

Each piece exists to close a specific, previously-real failure, not as
process for its own sake: an untracked plan ledger got lost once because
it lived only in one place, which is why Step 4's files are git-tracked
and Step 5 mirrors memory into the repo too. The "ask before branch
protection" line in Step 6 is there because that setting is genuinely
disruptive if it's wrong for how this particular team works, and a nod
up front is cheap compared to untangling it after the fact.
