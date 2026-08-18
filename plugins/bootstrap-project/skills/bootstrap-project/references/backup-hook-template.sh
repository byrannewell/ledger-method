#!/usr/bin/env bash
# Back up Claude Code's persistent, otherwise-untracked project state into
# this git repo, so it can never be lost by living only on one machine's
# disk.
#
# Mirrors:
#   - Claude's typed project memory  (<<MEMORY_DIR>>)  -> docs/claude-memory/
#   - Loose ledger/tracker files in ~/.claude/plans/*.md -> docs/superpowers/plans/
# Then commits ONLY those paths, quietly, if anything changed. Safe to run
# from a Stop hook: it no-ops when there's nothing to back up and refuses
# to run mid-rebase.
#
# Manual use:  bash scripts/backup-claude-state.sh
set -euo pipefail

REPO="<<REPO_PATH>>"
MEM="<<MEMORY_DIR>>"
PLANS="$HOME/.claude/plans"
cd "$REPO" || exit 0

# Don't touch git during a rebase/merge/bisect.
if [ -e .git/rebase-merge ] || [ -e .git/rebase-apply ] || [ -e .git/MERGE_HEAD ]; then
  exit 0
fi

mkdir -p docs/claude-memory docs/superpowers/plans

# 1) memory mirror (delete removed files so the backup matches live state)
[ -d "$MEM" ] && rsync -a --delete --exclude '.DS_Store' "$MEM/" docs/claude-memory/ 2>/dev/null || true
if [ ! -f docs/claude-memory/README.md ]; then
  printf '# Claude memory backup\n\nVersion-controlled mirror of Claude'\''s project memory. Restore from here if the live copy is lost.\n' > docs/claude-memory/README.md
fi

# 2) loose ledgers/trackers that live untracked in ~/.claude/plans
if [ -d "$PLANS" ]; then
  for f in "$PLANS"/*LEDGER*.md "$PLANS"/*REV-TRACKER*.md "$PLANS"/*PLAYBOOK*.md; do
    [ -f "$f" ] && cp "$f" docs/superpowers/plans/ 2>/dev/null || true
  done
fi

# 3) stage the backup paths
git add docs/claude-memory docs/superpowers/plans/*LEDGER*.md docs/superpowers/plans/*REV-TRACKER*.md docs/superpowers/plans/*PLAYBOOK*.md 2>/dev/null || true
if git diff --cached --quiet -- docs/claude-memory docs/superpowers/plans 2>/dev/null; then
  exit 0  # nothing changed
fi

# Don't auto-commit onto the trunk branch (would diverge from origin).
# On the trunk, only stage — the mirror rides along with the next real PR.
# On a feature branch, commit (it squashes away on merge) so the backup is
# never left merely on-disk.
TRUNK="<<TRUNK_BRANCH>>"
BRANCH="$(git branch --show-current 2>/dev/null || echo)"
if [ "$BRANCH" = "$TRUNK" ] || [ -z "$BRANCH" ]; then
  exit 0
fi

# No [skip ci] here on purpose: if this commit becomes a PR's head commit,
# [skip ci] would skip the pull_request workflows too, required checks
# would never report, and the PR couldn't merge under branch protection.
git commit -q -m "chore(backup): sync Claude memory + ledgers" \
  -- docs/claude-memory docs/superpowers/plans/*LEDGER*.md docs/superpowers/plans/*REV-TRACKER*.md docs/superpowers/plans/*PLAYBOOK*.md 2>/dev/null || true
