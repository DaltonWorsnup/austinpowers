---
name: using-austinpowers
description: >
  BLOCKING REQUIREMENT — invoke this skill BEFORE writing any code, editing
  files, debugging, planning, reviewing, or making any technical or knowledge-work
  decisions beyond reading files. This is the mandatory workflow router for ALL
  tasks. Matches: "implement", "build", "fix", "debug", "refactor", "plan",
  "write", "analyze", "decide", "review", "design", "research", or ANY request
  that involves doing work. Do NOT skip this skill even if the task seems simple.
  Invoke FIRST, then follow its routing.
---

# Using Austin Powers

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill entirely.
</SUBAGENT-STOP>

## Trigger Conditions

This skill MUST be invoked when any of the following occur:

- A new session starts with any non-trivial request
- The user gives a new task or changes topic mid-session
- Any work is about to begin without a skill selected
- The user asks "what should I use" or "which workflow"

**Exception:** Micro tasks (typo fix, single variable rename, 1-line config change) can skip the entry sequence entirely. Just do them.

## When the User Names a Specific Skill

If the user's prompt references a skill by name (e.g., "use brainstorming," "use task-routing," "run verification"), that is a **Skill tool invocation request**:

1. Still complete Entry Sequence steps 1–6 (token-efficiency, staleness check, etc.) — these are always-on prerequisites, not routing.
2. **Invoke the named skill via the `Skill` tool.** Do not re-implement the skill's purpose with ad-hoc agents, manual file reads, or improvised workflows.
3. Skip complexity classification and routing (step 7) — the user already chose the route.

## Instruction Priority (highest to lowest)

1. Explicit user instructions in the current conversation
2. Project-level CLAUDE.md / AGENTS.md
3. austinpowers skill instructions

If a user explicitly overrides a skill's behavior, follow the user. Skills are defaults, not mandates.

## Core Rule

Before technical or knowledge-work execution, select workflow skills explicitly and follow them.

Execution includes: code edits, debugging, planning, writing, analysis, review, research, branch integration, and any artifact production.

## Entry Sequence

1. Invoke `token-efficiency` at session start — applies to all sessions, always.
2. **Fresh project gate** — evaluate both conditions in order:
   - The user's request contains creation/build intent: any of "build", "create", "make", "implement", "scaffold", "set up", "write", "generate", "develop", "start", "plan", "design"
   - Run a filesystem check: `ls project-map.md 2>/dev/null` — gate only fires if the file does **not** exist

   If both are true, **pause before proceeding** and tell the user exactly this:

   > Before I start: this directory has no memory files set up yet. That matters for how well I perform across sessions.
   >
   > **Without setup, every future session on this project starts from scratch.**
   >
   > **A ~30-second setup changes that permanently:**
   > - `git init` — enables staleness tracking
   > - `project-map.md` — I read this at every future session start instead of re-exploring blind
   > - `session-log.md` — auto-captures decisions so future sessions start informed
   >
   > **Set this up before we build, or start immediately?**

   Wait for the user's answer before continuing.
   - **If they confirm:** run `git init --quiet`, then invoke `context-management` for map generation only. Return to step 3 when done.
   - **If they decline:** proceed to step 3.

   **Step 2b — Existing project memory check** (runs only when step 2 did NOT fire):
   If the user's request is non-trivial AND `project-map.md` does not exist AND the project has 10+ files:
   - Mention once: *"Note: this project has no project-map.md. I'll work fine without it, but if you want faster orientation in future sessions, I can generate one after this task."*

3. Classify the task as **micro**, **lightweight**, or **full** (see Complexity Classification below).
4. If resuming work from a prior session, read `state.md` if it exists. Before ending any session where significant decisions were made, invoke `context-management` to write a `[saved]` entry.
5. If `known-issues.md` exists at the project root, read it to avoid rediscovering known error→solution mappings.
6. If `project-map.md` exists at the project root, read it. If `<project-map-stale>` is in context:
   - **With git:** run `git diff --name-only <map_hash> HEAD` to find changed files. Re-read only those.
   - **Without git:** compare map timestamp to file modification times. Re-read newer files.
7. **Determine domain via `task-routing`** — classify as software, knowledge-work, or hybrid. Then follow the Routing Guide for the appropriate domain.

## Complexity Classification

Classify every task into one of three levels. Do not invoke a separate skill for this — decide inline.

### Hard overrides — check these first

If any of the following are true, classify as **full** immediately:

- The change adds, modifies, or removes a condition, gate, or trigger that determines when behavior fires
- The change affects what the user sees or experiences (excluding cosmetic text changes to existing UI)
- The change modifies a file that other components depend on
- The change introduces a path or outcome that didn't exist before

**When in doubt, classify as full.**

### Micro (skip everything)
- Typo fix, single variable rename, 1-line config change
- **Action:** Just do it. No skills needed.

### Lightweight (fast path)
All of these must be true:
- Change scope is small (~2 files or fewer)
- No new behavior or architecture change
- No cross-module dependency risk
- No migration or data-shape change

**Before classifying as lightweight:** explicitly state in one sentence why each criterion is satisfied.

**Action:** Go directly to implementation. Gate: invoke `verification-before-completion` when done.

### Full (complete pipeline)
Anything that doesn't qualify as micro or lightweight.

**Action:** Follow the Routing Guide below.

## EnterPlanMode Intercept

If about to enter plan mode, check whether brainstorming has been completed for the current task:

- **No brainstorming done**: invoke `brainstorming` first.
- **Brainstorming already completed and design approved**: proceed to `writing-plans`.

## Routing Guide

### Software Engineering Tasks

- Uncertain whether work should exist at all: `premise-check`
- Complex decision with unclear options: `deliberation` → `brainstorming` → `writing-plans`
- New feature or architecture (well-framed): `brainstorming` → `writing-plans`
- Plan execution (same session, parallel): `subagent-driven-development`
- Plan execution (separate session): `executing-plans`
- Experimental or risky work: `using-git-worktrees` (before implementation)
- Bug/test failure: `systematic-debugging` → `test-driven-development`
- Completion claim: `verification-before-completion`
- Work unit completion: `finishing-a-work-unit`
- Code review: `requesting-code-review` / `receiving-feedback`
- Independent parallel tasks: `dispatching-parallel-agents`
- Cross-session state: `context-management`
- Known issue tracking: `error-recovery`
- Code restructuring without behavior change: `refactoring`
- Performance issues: `performance-investigation`
- Dependency updates: `dependency-management`
- UI/frontend: `frontend-design`
- CLAUDE.md creation: `claude-md-creator`

### Knowledge-Work Tasks

- Uncertain whether work is worth doing: `premise-check`
- Complex decision with competing perspectives: `deliberation` → `brainstorming`
- Figuring out what to build/write/decide: `brainstorming` → `writing-plans`
- Plan execution: `following-your-plan`
- Something broken or underperforming: `systematic-problem-solving`
- Completion claim: `verification-before-completion`
- Received feedback/critique: `receiving-feedback`
- Authoring a new skill: `writing-skills`
- Cross-session state: `context-management`

### Hybrid Tasks

Tasks that mix software and knowledge work (technical writing, architecture, data analysis, product strategy, documentation, research for implementation):

1. Run `task-routing` to identify which domain is primary.
2. If roughly equal: use the software pipeline for any deliverable that is code or configuration; use the knowledge-work pipeline for prose, decisions, and strategy.
3. For technical writing: `brainstorming` → `writing-plans` → `following-your-plan` (knowledge-work pipeline, but include code examples as artifacts where needed).
4. For architecture design: `brainstorming` (sp-mode) → `writing-plans` (sp-mode) — architecture is ultimately a code artifact.
5. For data analysis: `systematic-problem-solving` if investigating something broken; `brainstorming` → `writing-plans` if producing analysis output.
6. For product strategy: `brainstorming` → `writing-plans` → `following-your-plan` (knowledge-work pipeline).
7. For documentation: `brainstorming` → `writing-plans` → `following-your-plan` (knowledge-work, but link to code as source of truth).

## Context Hygiene

For subagent handoffs, include only current task scope, constraints, evidence, and references to `state.md` when needed.

Avoid carrying forward long assistant reasoning chains unless they contain required artifacts.

## Red Flags

- "I'll just do this first without a skill"
- "Keep all prior assistant text in context"
- Claiming "done" without running verification

If a red flag appears, restart from Entry Sequence.
