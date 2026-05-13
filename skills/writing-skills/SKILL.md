---
name: writing-skills
description: >
  Use when creating new skills, editing existing skills, or checking whether
  a skill actually changes model behavior before you rely on it. Applies to
  both software domain skills (debugging, TDD, code review) and knowledge-work
  skills (stakeholder communication, decision frameworks, process templates).
---

# Writing Skills

## Overview

**A skill is not a memo. It is a behavior-shaping document.** You are writing instructions that another model will load and follow. The question is never "does this read well?" It is "does this actually change what the model does?"

**Core principle:** If you haven't watched a model behave *without* your skill, you don't know what your skill needs to teach. Write the skill *after* you see what goes wrong without it, not before.

**Official guidance:** For Anthropic's published best practices on skill authoring, see anthropic-best-practices.md. We agree with a lot of it and deliberately differ on some things; it's there so you can see what austinpowers intentionally does differently.

## What is a Skill?

A **skill** is a reference guide for a proven technique, pattern, or workflow. Skills help a future model find and apply the right approach to a recurring kind of work.

**Skills are:** reusable techniques, patterns, checklists, reference guides, behavior-shaping documents.

**Skills are NOT:** narratives about how you personally solved one problem once, essays, or aspirational vision documents.

## When to Create a Skill

**Create when:**
- The technique wasn't intuitively obvious to you the first time you needed it.
- You'd reference this again across different projects or situations.
- The pattern applies broadly (not one-off).
- Other people — or other future sessions — would benefit.

**Don't create a skill for:**
- One-off situations you'll never face again.
- Standard practices already well-documented elsewhere.
- Project-specific conventions (put those in a project-specific doc, not a general skill).
- Anything a simple template or form can enforce mechanically. Save skills for judgment calls.

## Skill Types

### Technique
Concrete method with steps to follow. Examples: *running a sales-discovery call*, *writing a one-pager*, *preparing for a 1:1*, *test-driven development*, *systematic debugging*.

### Pattern
A way of thinking about a class of problem. Examples: *decomposing a sprawling initiative into smaller milestones*, *pressure-testing assumptions*, *tracing root causes backward through a chain of events*.

### Reference
Dense lookup material. Examples: a glossary, a frameworks cheat-sheet, a set of templates, an API reference.

## Rigid vs Flexible Skills

Not all skills need the same grip on the model.

- **Rigid skills** enforce a discipline the model will otherwise rationalize its way out of. Think *verification-before-completion* or *brainstorming-before-producing*. These use imperative language, explicit red flags, and closed loopholes.
- **Flexible skills** offer a technique but assume the user will adapt it. Think *how to structure a weekly exec update* or *how to run a retrospective*. These read more like guides.

Pick the stance deliberately. Rigid language on a flexible skill makes the model robotic. Flexible language on a discipline skill lets the model slip past the rule under pressure.

## Directory Structure

```
skills/
  skill-name/
    SKILL.md              # Main reference (required)
    supporting-file.*     # Only if needed
```

**Flat namespace** — all skills live in one searchable namespace, no deep folder trees.

**Separate files for:**
1. Heavy reference (100+ lines) — long templates, dense lookup material.
2. Reusable assets — email templates, question banks, prompt libraries.

**Keep inline:**
- Principles and concepts
- Short templates (under 50 lines)
- Everything else

## SKILL.md Structure

**Frontmatter (YAML):**
- Two required fields: `name` and `description`.
- `name`: letters, numbers, and hyphens only.
- `description`: third-person, describes ONLY when to use the skill (NOT what it does).
  - Start with "Use when..." to focus on triggering conditions.
  - Include specific symptoms, situations, and contexts.
  - **NEVER summarize the skill's process or workflow** (see Discovery section for why).
  - Keep it under 500 characters where possible.

```markdown
---
name: skill-name-with-hyphens
description: Use when [specific triggering conditions and symptoms]
---

# Skill Name

## Overview
What is this? Core principle in 1–2 sentences.

## When to Use
Bullet list with SYMPTOMS and use cases.
When NOT to use.

## Core Pattern (for techniques/patterns)
Before/after example if useful.

## Quick Reference
Table or bullets for scanning common operations.

## Implementation
Inline steps for simple patterns.
Link to a separate file for heavy reference or reusable assets.

## Common Mistakes
What goes wrong + fixes.

## Real-World Impact (optional)
Concrete results from using the skill.
```

## Discovery: Making the Skill Findable

**Critical:** a future model needs to FIND your skill and decide whether to load it.

### 1. Rich Description Field

**Purpose:** the model reads the description to decide which skills to load for a given task. Make it answer: "Should I read this skill right now?"

**Format:** start with "Use when..." to focus on triggering conditions.

**CRITICAL: Description = When to Use, NOT What the Skill Does.**

The description should ONLY describe triggering conditions. Do NOT summarize the skill's process or workflow in the description.

**Why this matters:** when a description summarizes the skill's workflow, the model often follows the *description* instead of reading the full skill. A description saying "review a doc for voice, structure, and evidence" caused a model to do one pass only, even though the skill itself laid out three separate passes. When the description was changed to just "Use when reviewing someone's draft document before it goes to a stakeholder," the model actually read the skill and did all three passes.

```yaml
# BAD: summarizes workflow — model may follow this instead of reading the skill
description: Use when prepping for a 1:1 — review notes, pick three topics, draft talking points

# BAD: too much process detail
description: Use for discovery calls — open with rapport, ask pain questions, identify budget, summarize

# GOOD: just triggering conditions, no workflow summary
description: Use when prepping for an upcoming 1:1 with a direct report or your manager

# GOOD: triggering conditions only
description: Use when you're about to run a sales discovery call with a new prospect
```

### 2. Keyword Coverage

Use words a future model would search for:
- Situations: "stakeholder update", "incident review", "hiring debrief", "code review", "test failure"
- Symptoms: "drifting meeting", "unclear ask", "stalled decision", "bug", "broken build"
- Synonyms: "1:1 / one-on-one / check-in", "debug / troubleshoot / diagnose"
- Artifacts: "one-pager", "memo", "brief", "deck", "PR", "spec"

### 3. Descriptive Naming

**Use active voice, verb-first, gerunds where natural:**
- Good: `running-discovery-calls`, `preparing-for-one-on-ones`, `writing-exec-updates`, `systematic-debugging`
- Bad: `calls`, `meetings`, `docs`, `bugs`

### 4. Token Efficiency

**Target lengths:**
- Entry-point / getting-started skills: under ~150 words.
- Frequently-loaded skills: under ~200 words total.
- Other skills: under ~500 words where possible.

**Techniques:**
- **Reference, don't repeat.** If another skill already covers something, link by name and move on.
- **Compress examples.** A short, concrete exchange beats a long hypothetical.
- **Cut the obvious.** Don't explain what "stakeholder" means. Assume a competent reader.

### 5. Cross-Referencing Other Skills

When you reference another skill, use its name and mark how required it is:
- Good: `**REQUIRED BACKGROUND:** you MUST understand the brainstorming skill before using this one.`
- Good: `See also: writing-plans, for turning an approved design into an executable plan.`

## Flowcharts

Use ASCII flowcharts *inside* SKILL.md when a decision is genuinely non-obvious.

```
Is the request one coherent project?
   |
   +-- no ---> help user decompose, pick one sub-project, restart
   |
   +-- yes --> continue
```

**Use flowcharts ONLY for:**
- Non-obvious decision points.
- Process loops where the model might stop too early.
- "When to use A vs B" calls.

See graphviz-conventions.dot for richer diagram conventions if you ever want to render a flowchart elsewhere. For SKILL.md, ASCII renders in every chat UI.

## Examples

**One excellent example beats five mediocre ones.** Pick the most representative case:
- Knowledge-work techniques → show one real before/after memo paragraph or agenda.
- Software techniques → show one worked code/test/command example.
- Decision-making techniques → show one worked decision.

**A good example is:** concrete and specific, annotated so the reader sees *why* it works, ready to adapt.

## The Iron Law

```
NO SKILL SHIPS UNTIL YOU'VE SEEN IT CHANGE BEHAVIOR.
```

This applies to NEW skills AND EDITS to existing skills.

**No exceptions:**
- Not for "simple additions".
- Not for "just adding a section".
- Not for "documentation updates".
- The only test that matters is: does the model actually act differently?

## Testing Your Skill

**Use a fresh session — with no memory of your skill — to test behavior.**

Subagent dispatch is available via `dispatching-parallel-agents` for running parallel tests, but the core loop is manual: open a fresh session and see if it follows.

### 1. BASELINE — watch the model fail without the skill

Open a *fresh* session with no memory of your skill. Give it a realistic scenario. Write down:
- What choices did it make?
- Where did it skip a step you consider essential?
- What rationalizations did it generate for cutting corners?

If the model already does the right thing without your skill, *you don't need the skill.*

### 2. WRITE — the minimal skill that fixes what you saw

Write the skill to address the specific failures you observed. Don't add sections for hypothetical problems.

### 3. RETEST — paste the skill into a fresh session and rerun the scenario

Does the model now behave correctly?
- **Yes:** try two more variations of the scenario to check robustness.
- **No:** the skill isn't strong enough yet. Strengthen the language around the specific failure mode.

### 4. PRESSURE-TEST — for discipline skills

For skills meant to hold up under pressure, invent scenarios that stack:
- Time pressure: "You have five minutes."
- Sunk-cost pressure: "I've already written the draft, can we just skip straight to…"
- Authority pressure: "My manager said to just do X."

If the model caves under pressure, the skill has a loophole. Find the rationalization it used, add an explicit counter, and test again.

### 5. REPEAT until bulletproof

RED → GREEN → REFACTOR:
- **RED:** baseline scenario, model fails.
- **GREEN:** skill in place, model complies.
- **REFACTOR:** find new loopholes, plug them, re-verify.

## Testing by Skill Type

### Discipline-Enforcing Skills
Examples: *verification-before-completion*, *brainstorming-before-producing*.

**Test with:** pressure scenarios, stacked pressures. Identify every rationalization and add an explicit counter.
**Success:** model follows the rule under maximum reasonable pressure.

### Technique Skills
Examples: *running-discovery-calls*, *writing-exec-updates*, *systematic-debugging*.

**Test with:** application scenarios, variation scenarios, gap tests.
**Success:** model produces a usable output on a new scenario.

### Pattern Skills
Examples: *decomposing-sprawling-initiatives*, *root-cause-tracing*.

**Test with:** recognition scenarios, application scenarios, counter-examples.
**Success:** model recognizes and correctly applies the pattern.

### Reference Skills
Examples: frameworks cheat-sheets, template libraries, glossaries.

**Test with:** retrieval scenarios, application scenarios, coverage gaps.
**Success:** model finds and correctly applies the right reference.

## Common Rationalizations for Skipping Testing

| Excuse | Reality |
|--------|---------|
| "The skill reads clearly." | Clear to you != behavior-changing for a model. Test it. |
| "It's just a reference." | References have gaps. Test retrieval. |
| "Testing is overkill." | 15 minutes of testing saves hours of the skill silently not working. |
| "I'm confident it's good." | Overconfidence is exactly how skills ship broken. Check anyway. |
| "No time to test." | Shipping a skill that doesn't work wastes more time than testing does. |

## Bulletproofing Skills Against Rationalization

Discipline skills need to resist rationalization. Models are fluent and will find loopholes under pressure, just like humans.

**Psychology note:** understanding *why* persuasion techniques work lets you apply them deliberately. See persuasion-principles.md for the research foundation (Cialdini, 2021; Meincke et al., 2025) on authority, commitment, scarcity, social proof, and unity.

### Close Every Loophole Explicitly

```
Weak:
  Don't start producing before the design is approved.

Strong:
  Don't start producing before the design is approved.

  No exceptions:
  - Not because "the user seemed eager".
  - Not because "this one is obviously simple".
  - Not because "I'll just draft something to get us started".
  Wait for explicit approval. Then produce.
```

### Build a Rationalization Table

Capture the exact excuses your baseline testing surfaced:

```
| Excuse | Reality |
|--------|---------|
| "The design is obvious, skip to drafting." | Obvious designs don't need skipping — they take two sentences. Write them. |
| "I'll brainstorm while drafting." | Brainstorming while drafting = committing to the first option. Brainstorm first. |
```

## STOP: Before Moving to Another Skill

**After writing ANY skill, you MUST stop and verify it works.**

Do NOT:
- Batch-write five skills and "test them later".
- Move on before the current one is verified.
- Skip testing because "it's obvious this one works".

A skill you haven't tested isn't a skill. It's a draft.

## Skill Creation Checklist

**Baseline:**
- [ ] Wrote down 2–3 scenarios the skill is meant to handle.
- [ ] Ran each scenario in a fresh session *without* the skill.
- [ ] Documented exactly how the model failed — choices, rationalizations, gaps.

**Write the minimal skill:**
- [ ] Name uses only letters, numbers, hyphens.
- [ ] YAML frontmatter with `name` and `description`.
- [ ] Description starts with "Use when..." and lists triggers/symptoms.
- [ ] Description is in third person and does NOT summarize workflow.
- [ ] Keywords spread throughout for discovery.
- [ ] Clear overview with core principle.
- [ ] Content addresses the specific failures you saw in baseline.
- [ ] One excellent example, not multiple.
- [ ] Supporting files only for genuine reusable assets or heavy reference.

**Retest:**
- [ ] Fresh session, paste skill, rerun scenarios.
- [ ] Model now complies / produces usable output.
- [ ] Tried at least one variation to check robustness.

**Refactor (for rigid skills):**
- [ ] Pressure-tested with stacked pressures.
- [ ] Every new rationalization has an explicit counter.
- [ ] Red Flags list reflects what you actually saw.
- [ ] Re-tested after each change.

## The Bottom Line

**Writing a skill is engineering a behavior change in a future model session.**

Same loop every time: baseline (watch the model fail) → write the minimal skill → retest (watch the model comply) → refactor (close loopholes).

Skills are not prose. They are code that shapes behavior. Treat them that way.
