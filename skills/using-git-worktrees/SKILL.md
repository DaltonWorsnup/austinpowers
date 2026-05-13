---
name: using-git-worktrees
description: >
  Use before implementation or major revision when work should be isolated
  from the current main line. For software: create a git worktree on a
  new branch. For knowledge-work: create a working copy or draft version
  before editing the source. Triggers on: "use a worktree", "isolate this
  work", "don't touch main", experimental changes, or major document
  revisions where the original must be preserved.
---

# Using Git Worktrees (and Draft Isolation)

Create an isolated workspace — either a git worktree branch or a working copy of a document — so the main line of work stays clean during experimentation or major revision.

## Required Start

Announce: `I'm using the using-git-worktrees skill to set up an isolated workspace.`

---

## Software: Git Worktrees

### Directory Selection Priority

Check in order:

```bash
ls -d .worktrees 2>/dev/null     # Preferred (hidden)
ls -d worktrees 2>/dev/null      # Alternative
```

1. If `.worktrees/` exists — use it. If both exist, `.worktrees/` wins.
2. If `worktrees/` exists — use it.
3. Check project guidance file (e.g. `CLAUDE.md`) for a stated preference:
   ```bash
   grep -i "worktree.*director" CLAUDE.md 2>/dev/null
   ```
4. Ask user.

### Safety Check

For project-local worktree directories, verify ignore rules before creating:

```bash
git check-ignore -q .worktrees 2>/dev/null || git check-ignore -q worktrees 2>/dev/null
```

If **not** ignored:
1. Add the appropriate line to `.gitignore`.
2. **Commit the `.gitignore` change immediately** before proceeding — an uncommitted ignore entry is easy to lose and leaves the worktree contents exposed to accidental staging.

### Creation Steps

#### 1. Detect project root and branch name

```bash
project=$(basename "$(git rev-parse --show-toplevel)")
```

Choose a descriptive `BRANCH_NAME` for the feature being isolated.

#### 2. Create worktree and branch

```bash
git worktree add <path> -b <BRANCH_NAME>
```

**Critical:** The `cd <path>` in this step does not persist across separate shell calls. Use the full worktree path — `cd <path> && <command>` — in every subsequent Bash call rather than assuming the working directory carried over.

#### 3. Run project setup

Auto-detect the project ecosystem and run the appropriate setup:

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

If none of these files exist, skip dependency installation and note it in the output.

#### 4. Run baseline tests

Run the project-appropriate test command to confirm the worktree starts clean:

```bash
# Use whichever applies
npm test
cargo test
pytest
go test ./...
```

### Failure Handling

If baseline tests fail, report the failures and ask whether to continue or investigate before proceeding.

### Success Output

Report:
- Worktree path (full absolute path)
- Branch name
- Ecosystem detected and setup command(s) run
- Baseline test status (passing count or failure summary)

### Integration

Use with:
- `writing-plans`
- `subagent-driven-development` — REQUIRED before executing any tasks
- `executing-plans` — REQUIRED before executing any tasks

Cleanup is handled by `finishing-a-work-unit`.

---

## Knowledge-Work: Draft Isolation

When a knowledge-work task involves major revisions to a live document, plan, or analysis — especially if the original is shared with stakeholders or used by other processes — work in an isolated copy before touching the source.

### When to isolate

- The document is shared and live (e.g., a team wiki page, a board-facing slide deck, a plan that others are executing)
- You're making structural changes that might not be approved (reordering sections, changing the recommendation)
- You want to explore an alternative direction without committing
- The work will take multiple sessions and you don't want a half-finished revision to be visible

### How to isolate (knowledge-work)

1. **Create a working copy** with a clear name:
   - `YYYY-MM-DD-<doc-name>-DRAFT.md` for documents
   - `YYYY-MM-DD-<plan-name>-REVISION.md` for plans
   - Keep the original untouched at its current path

2. **Work in the copy** — apply all edits to the copy, not the original.

3. **Review the copy** with the user before replacing the original.

4. **Merge or replace**: once the draft is approved, either:
   - Replace the original file with the draft
   - Or copy the approved sections back into the original manually (preferred when only part of the doc changes)

5. **Clean up**: delete the draft copy once the changes are in the original.

### Integration

- Use `following-your-plan` to execute the revision tasks in the draft copy.
- Use `verification-before-completion` to confirm the draft meets requirements before replacing the original.
- Use `finishing-a-work-unit` to decide whether to publish, archive, or discard.
