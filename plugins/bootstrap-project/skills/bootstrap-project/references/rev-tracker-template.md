# <PROJECT>-REV-TRACKER.md template

This is the deferred-work triage — the durable home for everything raised,
judged real, and deliberately *not* done right now. Its entire reason to
exist is that a deferral mentioned only in a PR description is not
visibility; it's a note nobody will read again. Anything deferred goes
here, every time, no exceptions for "small" items.

Write the file at `docs/superpowers/plans/<PROJECT>-REV-TRACKER.md`:

```markdown
# <PROJECT> REV TRACKER — post-launch work, git-backed

**Purpose:** the durable, findable home for everything decided as
NOT-happening-right-now. Rev0 = not blocking whatever's currently gating
release, but urgent — do it next. Rev1 = needed, tackle right after the
current release cycle. Rev2 = next-version material, ideally once
there's real usage to prioritize against. Update this file whenever
something is deferred; review it when planning the next work cycle.

**The tier is not the agent's call.** An agent proposes — "here's what I
found, and here's why it looks Rev1-shaped" — and the project owner
rules on the tier. That boundary is what keeps this file trustworthy
instead of turning into a second backlog nobody trusts.

## Rev0 (urgent, not currently blocking)

| Item | What | Notes |
|---|---|---|
| — | *(example — replace/remove)* **Billing entitlement check swallows its read error.** `getEntitlement()` in `src/lib/billing/x.ts:83` destructures `{ data }` and discards `error`, so any transient read failure renders as "no entitlement" and bounces a paying customer to the upgrade wall — silently. Reproduced by killing the DB connection mid-request; confirmed in logs on <date>. | Raised <date> during <what surfaced it>. Tier: **Rev0** — a swallowed error that can silently paywall a paying customer, ruled urgent by <owner> on <date>. |

## Rev1 (needed, after this release cycle)

| Item | What | Notes |
|---|---|---|

## Rev2 (next version)

| Item | What | Notes |
|---|---|---|
```

## What makes a row usable

Every row cites its evidence the same way a debugging write-up would — a
file and line number, a reproduction, a direct quote from whoever raised
it. "This seems slow" is not a row; "P95 on `/api/x` measured at 1.4s
across 20 requests on `<date>`, see `docs/perf/<file>`" is. The example
row above is deliberately dense — that's the bar, not decoration.
