---
name: task-routing
description: >
  Use when the task domain is ambiguous and you need to determine whether to apply
  software engineering workflows, knowledge-work workflows, or a hybrid approach.
  Invoked by using-austinpowers step 7 for non-trivial tasks. Also useful when
  the user asks "which mode should I use" or when a task spans both domains.
---

# Task Routing

Classify the current task as **software**, **knowledge-work**, or **hybrid**, then route to the appropriate skill pipeline.

## Classification

### Software Engineering Tasks

Apply the software pipeline when the primary deliverable is:
- Code, tests, or configuration
- A deployed system or service change
- A bug fix with a reproduction case
- A performance improvement measured by benchmarks
- A dependency upgrade or migration
- A CI/CD or infrastructure change
- A refactoring of existing code
- A UI/frontend component or page

**Signal words:** implement, debug, test, deploy, build, compile, refactor, optimize (for code), migrate, PR, branch, commit, merge.

**Examples:**
- "Add rate limiting to the API" → **software**
- "Fix the test that's been flaking in CI" → **software**
- "Upgrade React to v19" → **software**
- "Build a dashboard component" → **software**
- "Refactor the auth module" → **software**

### Knowledge-Work Tasks

Apply the knowledge-work pipeline when the primary deliverable is:
- A written document (memo, proposal, report, brief, plan, analysis)
- A strategic decision with options and a recommendation
- A process or workflow change (no code involved)
- A stakeholder communication (email, presentation, message)
- A diagnosis of an organizational or operational problem
- An interview, retrospective, or review (non-code)
- A research summary or synthesis

**Signal words:** write, draft, plan, decide, analyze (for data/strategy), recommend, communicate, review (a document), present, synthesize, diagnose (a business problem).

**Examples:**
- "Draft the Q3 product strategy memo" → **knowledge-work**
- "Figure out why our NPS dropped last month" → **knowledge-work**
- "Prepare talking points for the board presentation" → **knowledge-work**
- "Write the launch announcement email" → **knowledge-work**
- "Help me respond to the CEO's feedback on the roadmap" → **knowledge-work**

### Hybrid Tasks

Use when the task genuinely requires both pipelines — not because it's unclear, but because the deliverable spans both domains.

**Examples and routing decisions:**

| Task | Domain | Why | Pipeline |
|------|--------|-----|----------|
| Write the architecture design doc for a new service | Hybrid | Prose document, but content is a technical design | brainstorming (sp) → writing-plans (sp) → following-your-plan |
| Create technical documentation for the API | Hybrid | Prose deliverable, content derived from code | brainstorming → writing-plans → following-your-plan (treat code as a reference artifact) |
| Analyze user behavior data to inform a feature decision | Hybrid | Analysis (knowledge-work) + possible code (SQL/Python) | systematic-problem-solving if diagnosing; brainstorming → writing-plans if producing analysis |
| Debug a business process with a software component | Hybrid | Root cause may be code or org | systematic-problem-solving (knowledge-work) → systematic-debugging if root cause is code |
| Write a postmortem after a production incident | Hybrid | Prose deliverable, but requires technical root cause analysis | systematic-debugging first → then following-your-plan for writing |
| Design a data model for a new product | Hybrid | Technical decision, but also stakeholder-facing | brainstorming (sp) → writing-plans (sp) |
| Refactor a business process (not code) | Knowledge-work | Process, not code | brainstorming → writing-plans → following-your-plan |
| Non-code project planning with milestones and owners | Knowledge-work | No code deliverable | brainstorming → writing-plans → following-your-plan |
| Product strategy for a technical product | Hybrid | Strategy is knowledge-work; implications are software | brainstorming (hybrid) → writing-plans (np) → following-your-plan |

## Ambiguous Cases

### Technical writing
**Route:** knowledge-work pipeline.
The deliverable is a document. Even if the content is technical (API docs, runbooks, architecture docs), the production process follows the writing/planning discipline. Use `brainstorming` to establish audience, structure, and key claims. Use `writing-plans` to decompose the document into sections with exact proposed wording. Use `following-your-plan` to execute.

**Exception:** if the technical writing task requires generating code samples that will be tested, treat those samples as software tasks nested inside the broader knowledge-work task.

### Architecture design
**Route:** software pipeline.
An architecture design eventually becomes a code system. Even if the current deliverable is a design doc, use the software brainstorming checklist (which includes codebase inspection and failure-mode checks) to produce a higher-quality design. Save the design to `docs/specs/`.

### Debugging with strategic planning
**Route:** software pipeline (`systematic-debugging`), but if the debugging reveals an organizational or process issue, pivot to knowledge-work (`systematic-problem-solving`) for the fix.

### Research for implementation
**Route:** depends on output.
- If the output is a code change: software pipeline. Do the research as an inline step before implementation.
- If the output is a document or recommendation: knowledge-work pipeline.

### Non-code project planning
**Route:** knowledge-work pipeline.
Even if the project involves software teams, a project plan with milestones, owners, and dependencies is a knowledge-work artifact.

### Data analysis
**Route:** depends on the question.
- Diagnosing a problem (why did metric X drop?): `systematic-problem-solving`.
- Producing a report or recommendation: `brainstorming` → `writing-plans` → `following-your-plan`.
- Writing analysis code (SQL, Python, R): software pipeline for the code, knowledge-work pipeline for the narrative.

### Documentation
**Route:** knowledge-work pipeline.
Documentation is a document. Even if it lives in a code repo, the production discipline is writing, not coding.

### Refactoring prose or process
**Route:** knowledge-work pipeline.
If the user is "refactoring" a document (restructuring sections, tightening language, removing redundancy), that is a knowledge-work task. If they are refactoring code, use the software `refactoring` skill.

## Decision Flow

```
What is the primary deliverable?
      │
      ├── Code, tests, config, deployed system ──► software pipeline
      │
      ├── Document, decision, communication, analysis ──► knowledge-work pipeline
      │
      └── Both / unclear
              │
              ▼
      Is there a code deliverable at the end?
              │
              ├── yes ──► software pipeline (brainstorming will surface the prose parts)
              │
              └── no ──► knowledge-work pipeline
```

## Output

State the classification in one line:

> Task domain: **software** / **knowledge-work** / **hybrid (primary: software/knowledge-work)**

Then proceed to the appropriate routing in `using-austinpowers`.
