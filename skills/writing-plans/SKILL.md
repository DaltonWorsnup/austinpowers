---
name: writing-plans
description: >
  MUST USE after design approval to decompose requirements into executable task
  plans. For software tasks: includes TDD ordering, exact code, verification
  commands. For knowledge-work tasks: includes exact prose wording, stakeholder
  names, artifact locations. Triggers on: "write a plan", "break this down",
  "plan the implementation", after brainstorming approval.
  Routed by brainstorming as the next step.
---

# Writing Plans

Create an execution plan another agent or person can follow with minimal ambiguity.

## Output Path

- **Software tasks:** save to `docs/plans/YYYY-MM-DD-<feature-name>.md`
- **Knowledge-work tasks:** save wherever the user keeps project docs (Notion, shared drive, wiki, local folder). Ask if unclear. Filename: `YYYY-MM-DD-<initiative-name>-plan.md`

## Scope Check

If the spec covers multiple independent subsystems or workstreams, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans — one per subsystem/workstream. Each plan should produce a working, reviewable deliverable on its own.

## Domain Selection

Determine which task template to use based on the task type from `task-routing`. Both templates share the same structure (header, tasks with checkboxes, self-review, handoff) but differ in step content.

---

## Plan Header (both domains)

```markdown
# [Initiative/Feature Name] Plan

> **For the person executing this plan:** Use `austinpowers:following-your-plan` (knowledge-work) or `austinpowers:executing-plans` / `austinpowers:subagent-driven-development` (software) to work through this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [One sentence]
**Approach:** [2–4 sentences]
**Key inputs / Tech Stack:** [source material, stakeholders, data, prior decisions; or languages/libraries/tools]
**Assumptions:** [list key assumptions; for each, state what it excludes]

---
```

---

## Software Task Template

Before defining tasks, map out which files will be created or modified and what each one is responsible for. Design units with clear boundaries. Prefer smaller, focused files over large ones.

````markdown
### Task N: [Name]

**Files:**
- Create: `<path>`
- Modify: `<path>`
- Test: `<path>`

**Security flag:** `none` *(set to `security` if this task handles auth, credentials, input validation, permissions, crypto, or data access)*

**Does NOT cover:** *(required when this task adds a condition, gate, or trigger — state what the condition excludes)*

- [ ] **Step 1: Write failing test**

```<lang>
<actual test code>
```

- [ ] **Step 2: Run test to verify it fails**

Run: `<command>`
Expected: FAIL with "<expected failure reason>"

- [ ] **Step 3: Implement minimal change**

```<lang>
<actual implementation code>
```

- [ ] **Step 4: Run test to verify it passes**

Run: `<command>`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add <files>
git commit -m "<message>"
```
````

---

## Knowledge-Work Task Template

Before defining tasks, map out which documents, decks, memos, or artifacts will be created or modified. Design artifacts with clear boundaries and one clear purpose each.

```markdown
### Task N: [Artifact or Activity Name]

**Artifacts:**
- Create: `exact name and location of the new doc/deck/memo`
- Modify: `exact name and location of the existing artifact, section if relevant`
- Checkpoint: `who reviews it, or what self-check confirms it`

- [ ] **Step 1: Draft the opening**

> Proposed wording:
> "[exact text, not a description of what to write]"

- [ ] **Step 2: Verify the claim lands**

[Specific check: read it aloud, ask the named stakeholder, compare against the brief]
Expected: [what "passing" looks like]

- [ ] **Step 3: Share for review**

Send to [named reviewer] with the single question: "[exact question to ask]"
```

---

## No Placeholders (both domains)

Every step must contain the actual content an engineer or knowledge worker needs. These are **plan failures**:

- "TBD", "TODO", "implement later", "fill in details"
- "Add appropriate error handling" / "handle edge cases" / "address objections"
- "Write tests for the above" (without actual test code — software)
- "Write the rest of the memo" (without actual proposed wording — knowledge-work)
- "Similar to Task N" (repeat the content — the executor may read tasks out of order)
- Steps that describe what to do without showing how

## Self-Review (both domains)

After writing the complete plan, check it against the spec.

1. **Spec coverage:** can you point to a task that delivers every requirement?
2. **Placeholder scan:** any of the patterns from "No Placeholders"? Fix them.
3. **Consistency:** do names, signatures, and titles match across tasks? A function called `clearLayers()` in Task 3 but `clearFullLayers()` in Task 7 is a bug. A stakeholder called "the finance partner" in Task 2 but "the CFO" in Task 5 is too.
4. **Scope-reduction scan:** search for "v1", "basic", "simple", "for now", "placeholder". Each hit must be explicitly sanctioned by the user — not a quiet scope downgrade.

Fix issues inline. If you find a spec requirement with no task, add the task.

## Execution Handoff

After saving and self-reviewing the plan:

**Software tasks** — select execution approach:
1. Context window ≥ 60% full → **Subagent-Driven** (`subagent-driven-development`)
2. Task count ≥ 5 → **Subagent-Driven**
3. Heavy inter-task state sharing → **Inline** (`executing-plans`)
4. Default → **Subagent-Driven**

Output: `Plan saved to docs/plans/<filename>.md. Ready to execute with [Subagent-Driven / Inline] (<N> tasks). Reply to start.`

**Knowledge-work tasks** — tell the user:
`Plan complete and saved. Next step: apply the austinpowers:following-your-plan skill to work through it task-by-task.`

**Stop here.** Do not invoke any execution skill until the user replies.
