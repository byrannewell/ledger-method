# AGENTS.md template

A small, separate file for framework/library gotchas that training data
will get wrong — version-specific breaking changes, "the docs shipped in
node_modules are the real ones, not what you remember." Keep it short; it
exists to prevent one specific class of confident-but-wrong code, not to
hold general project context (that's CLAUDE.md's job).

If nothing about this stack has that kind of churn yet, don't pad it —
write the honest one-liner version:

```
<Project name> has no framework-version gotchas recorded yet. If you hit
one (a breaking change, a deprecated API your training data doesn't
know about), add it here so the next session doesn't rediscover it.
```

Otherwise, the shape that's proven useful — one block per framework/library
worth flagging:

```
<!-- BEGIN:<framework>-agent-rules -->
# <Framework> — <short warning>

<One or two sentences: what changed, where the authoritative docs live
now (a vendored docs path beats a remembered API), and what to do before
writing code against it — e.g. "read the relevant guide in
node_modules/<pkg>/dist/docs/ before writing any code.">
<!-- END:<framework>-agent-rules -->
```

The HTML comment markers aren't decorative — they let a future edit (by a
human, a skill, or a version-bump script) find and replace exactly one
block without disturbing the others.
