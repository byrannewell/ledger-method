# The Ledger Method

A personal Claude Code plugin marketplace with one plugin: **`bootstrap-project`**
— a skill that sets up a brand-new project with a spec-driven-development
discipline battle-tested on a production app (root-cause before fix, plan
before code, evidence before claims, tiered deferred-work tracking).

It rests on three layers, and this plugin only builds one of them:

1. **Discipline** — an installed plugin stack (brainstorm → plan → build
   → verify → ship). The skill checks this is on; it doesn't author it.
2. **Scaffolding** — `CLAUDE.md`, a `docs/` tree, two tracker files, a
   memory-backup hook. This is what `bootstrap-project` actually creates.
3. **Memory** — behavior, not a file. Nothing to install; it activates
   the first time something worth remembering happens.

## Install

```
/plugin marketplace add byrannewell/ledger-method
/plugin install bootstrap-project@ledger-method
```

No authentication needed — this is a public repo, so both commands work
cold on any machine with Claude Code.

## Use

In a brand-new (or early-stage) repo, ask for it in plain language —
"bootstrap this project with the Ledger Method," "set this up like
Pearsight," "I want good process from day one here." The skill will:

1. Confirm the underlying discipline plugins are enabled (`superpowers`,
   `remember`, `skill-creator`, `claude-md-management`, `frontend-design`,
   `feature-dev`, `code-simplifier`, `context7`).
2. Ask the handful of things it can't infer — project name, repo URL, a
   few locked-in stack decisions, the trunk branch name.
3. Write `CLAUDE.md`, `AGENTS.md`, the `docs/` tree, a plan ledger, a
   rev-tracker, and a project-scoped memory-backup hook.
4. Tell you explicitly what it deliberately did *not* do (branch
   protection, any actual code) and why those need a separate nod.

See `plugins/bootstrap-project/skills/bootstrap-project/SKILL.md` for the
full mechanics, or just install it and ask.
