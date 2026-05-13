---
name: brainstorming
description: >
  MUST USE when the user wants new features, behavior changes, new projects,
  documents, decisions, plans, or any work where no approved design exists yet.
  Produces an approved design before any implementation or production begins.
  Triggers on: "build this", "create", "write", "plan", "decide", "design",
  "I want to", "help me", "we need to". Routed by using-austinpowers, or invoke
  directly via /brainstorming.
---

# Brainstorming

Turn rough requests into an approved design before any production begins.

## Hard Gate

Do not write code, edit files, draft documents, or invoke implementation skills until design approval is explicit.

## Anti-Pattern: "This Is Too Simple To Need A Design"

Every project goes through this process. A todo list, a one-pager, a quick email, a single utility function — all of them. "Simple" projects are where unexamined assumptions cause the most wasted work. The design can be short (a few sentences for truly simple projects), but you MUST present it and get approval.

## Checklist

1. **Understand context** — what's already been decided, who the audience or users are, what constraints exist (deadline, budget, stakeholders, codebase conventions).
2. **Assess scope** — if the project touches 4+ independent subsystems or deliverables, or would require 20+ tasks, decompose into sub-projects. Present the decomposition and get approval before designing individual specs.
3. **Ask clarifying questions** — gather all unknowns in a single turn (use multiple-choice format where possible to reduce round trips). Focus on: purpose, constraints, success criteria, audience.
4. **Propose 2–3 approaches** — with trade-offs and a recommended choice. Lead with your recommendation and explain why.
5. **Context-specific steps** — apply the appropriate steps for the task domain (see below).
6. **Present design in short sections** — confirm each section before moving on.
7. **Failure-mode check** — before approving: state the top 2–3 ways the chosen approach could fail or not cover key cases. For each:
   - **Critical** (design fails for a significant scenario): revise the design before proceeding.
   - **Minor** (acceptable edge case): document as a non-goal.
   Do not skip this step.
8. **Save approved design** — write to `docs/specs/YYYY-MM-DD-<topic>-design.md` (or wherever the user keeps project docs for knowledge-work tasks).
9. **Spec self-review** — check for placeholders, contradictions, ambiguity, scope creep. Fix inline.
10. **User reviews written spec** — ask the user to read the spec before proceeding.
11. **Invoke `writing-plans`.**

## Context-Specific Steps

### Software Engineering Tasks (step 5 content)

5a. Inspect relevant project files, recent commits, and existing patterns before proposing new ones. Match the project's conventions unless there's a compelling reason to diverge.
5b. Design for isolation — prefer changes that minimize blast radius and don't require coordinating across many files.
5c. If the repo lacks `CLAUDE.md` / `AGENTS.md` and long-term collaboration is expected, consider using `context-file-creator`.

### Knowledge-Work Tasks (step 5 content)

5a. Identify the audience and their context: what do they already know, what decision are they trying to make, what would they do differently after reading this?
5b. Understand where this work lives in a larger process: is it standalone, or does it feed into something else (a meeting, a decision, a handoff)?
5c. For decisions: identify who has approval authority and what their known constraints or preferences are.
5d. Break the work into units with clear purpose. For a document: one section per idea. For a decision: one option per comparison point. For an initiative: one milestone per outcome.

## Process Flow

```
Understand context
      │
      ▼
Is scope one coherent project?
      │
      ├── no ──► Decompose; design each sub-project separately
      │
      └── yes
          │
          ▼
Ask clarifying questions (all in one turn)
          │
          ▼
Propose 2–3 approaches with recommendation
          │
          ▼
Apply context-specific steps (software or knowledge-work)
          │
          ▼
Present design in sections; confirm each
          │
          ▼
Failure-mode check: top 2–3 ways this could fail
          │
          ├── critical failure found ──► revise design
          │
          └── no critical failures
              │
              ▼
Save spec to docs/specs/ (or user's preferred location)
              │
              ▼
Spec self-review (placeholders, contradictions, ambiguity)
              │
              ▼
User reviews written spec
              │
              ├── changes requested ──► revise, re-review
              │
              └── approved ──► invoke `writing-plans`
```

## After the Design

**Spec self-review checklist:**

1. **Placeholder scan** — any "TBD", "TODO", vague phrasing? Make it concrete or cut it.
2. **Internal consistency** — do any sections contradict each other?
3. **Scope check** — is this focused enough for a single plan?
4. **Ambiguity check** — could any requirement be interpreted two ways? Pick one.

Fix issues inline. Then ask:

> "Spec written. Please read it and let me know if you want to change anything before we move to the plan."

**Terminal state:** the ONLY next step after brainstorming is `writing-plans`. Do not start executing.

## Working in Existing Contexts

If the user is extending something that already exists (a running codebase, an ongoing document, an established process), understand it before proposing changes. Follow existing conventions. Where existing work has problems that affect the new work, include targeted fixes — the way a careful contributor improves something they're working in. Don't propose unrelated revisions.

## Key Principles

- **One question per turn** (use multiple-choice to reduce round trips)
- **YAGNI ruthlessly** — cut features/sections/steps nobody actually needs
- **Explore alternatives** — always propose 2–3 approaches before settling
- **Incremental validation** — present the design in sections, get approval, move on
- **Failure-mode check is mandatory** — no skipping
