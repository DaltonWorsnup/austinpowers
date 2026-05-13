---
name: systematic-problem-solving
description: >
  Invoke BEFORE attempting any fix when something went wrong — missed target,
  stalled initiative, broken process, stakeholder conflict, bug, error, or
  unexpected outcome. Enforces root-cause analysis before fixes. Triggers on:
  "it's broken", "not working", "missed the target", "process failed",
  "stakeholder is misaligned", "deal stalled", "metric regressed",
  "unexpected result". Also routed by using-austinpowers for problem tasks.
---

# Systematic Problem-Solving

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill entirely.
</SUBAGENT-STOP>

Do root-cause investigation before proposing fixes.

**Core principle:** ALWAYS find root cause before attempting fixes. Symptom fixes are failure.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed Phase 1, you cannot propose fixes.

## When to Use

Use for ANY situation where outcomes deviated from expectations:

- A campaign that underperformed its targets
- A product metric that regressed
- A team whose velocity dropped
- A hiring cycle that failed to close candidates
- A deadline that was missed
- A process that broke down at a handoff
- A stakeholder who lost confidence or became misaligned
- A decision that produced an unexpected outcome
- A bug, error, or test failure in software

**Use this ESPECIALLY when:**
- Under time pressure (emergencies make guessing tempting)
- "Just one quick fix" seems obvious
- You've already tried multiple fixes
- A previous fix didn't hold
- You don't fully understand what happened

**Don't skip when:**
- The issue seems simple (simple problems have root causes too)
- You're in a hurry (rushing guarantees rework)
- A stakeholder wants it fixed NOW (systematic is faster than thrashing)

## The Four Phases

You MUST complete each phase before proceeding to the next.

### Phase 1: Root Cause Investigation

**BEFORE attempting ANY fix:**

1. **Read the available evidence carefully**
   - Don't skim past what reporters, dashboards, logs, or participants actually said.
   - The signal you need is often in an aside, a footnote, or a stack trace line.
   - Note specific numbers, dates, names, and sequences.

2. **Reproduce the failure pattern**
   - Can you describe exactly what happened, step by step?
   - Does this pattern show up elsewhere (other campaigns, other teams, other code paths)?
   - If the pattern can't be reconstructed, gather more evidence before guessing.

3. **Check recent changes**
   - What changed in the period leading up to the problem?
   - New tooling, new people, new priorities, new market conditions, new code?
   - Check meeting notes, decision logs, git history, budget shifts.

4. **Gather evidence across every handoff in the process**

   **WHEN the work passes through multiple people or stages:**

   **BEFORE proposing fixes, instrument each handoff:**

   ```
   For EACH handoff between people or stages:
     - What inputs arrived?
     - What outputs went out?
     - Did expectations carry across, or get lost?
     - Who signed off, and on what?

   Gather evidence ONCE to show WHERE the chain broke
   THEN analyze to identify the failing handoff
   THEN investigate that specific handoff
   ```

5. **Trace the chain backward**

   **WHEN the visible failure is far downstream from the original cause:**

   See `root-cause-tracing.md` in this directory for the full backward tracing technique.

   **Quick version:**
   - Where did the first wrong decision or wrong input enter the chain?
   - Who handed that forward, and on what basis?
   - Keep tracing upstream until you reach the original trigger.
   - Fix at the source, not at the symptom.

### Phase 2: Pattern Analysis

**Find the pattern before fixing:**

1. **Find working examples** — locate a similar effort that succeeded. What works that resembles what's broken?
2. **Compare against references** — if you're following a playbook or precedent, read it completely. Don't skim.
3. **Identify differences** — list every difference between the working example and the broken one, however small.
4. **Understand dependencies** — what inputs, approvals, tools, or conditions does this depend on?

### Phase 3: Hypothesis and Testing

**Scientific method:**

1. **Form a single hypothesis** — "I think X is the root cause because Y." Write it down. Be specific.
2. **Test minimally** — make the SMALLEST possible change to test the hypothesis. One variable at a time.
3. **Verify before continuing** — did it work? Yes → Phase 4. Didn't work? Form a NEW hypothesis. DON'T stack more fixes.
4. **When you don't know** — say "I don't understand X." Ask for help. Do more research.

### Phase 4: Implementation

**Fix the root cause, not the symptom:**

1. **Define the success test up front** — the simplest possible observation that will tell you the fix worked. MUST exist before implementing.
2. **Implement a single fix** — address the root cause. ONE change at a time. No "while I'm here" additions.
3. **Verify the fix** — does the success test pass? Did anything else break?
4. **If the fix doesn't work** — STOP. Count fixes tried. If < 3: return to Phase 1. **If ≥ 3: STOP and question the underlying structure (step 5).**
5. **If 3+ fixes failed: question the structure** — each fix revealing a new failure elsewhere is a structural problem, not a hypothesis failure. Discuss with the decision-maker before attempting more fixes.

## Red Flags — STOP and Follow the Process

- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Let's launch several changes at once and see what sticks"
- "It's probably X, let me fix that"
- "I don't fully understand but this might work"
- "Here are the main problems: [lists fixes without investigation]"
- **"One more fix attempt" (when you've already tried 2+)**
- **Each fix reveals a new problem in a different place**

**ALL of these mean: STOP. Return to Phase 1.**

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple, doesn't need process" | Simple issues have root causes too. The process is fast for simple cases. |
| "Emergency, no time for process" | Systematic problem-solving is FASTER than guess-and-check thrashing. |
| "Just try this first, then investigate" | The first fix sets the pattern. Do it right from the start. |
| "I'll set up a success test after the fix works" | Unverified fixes don't stick. Define the test first. |
| "Multiple fixes at once saves time" | You can't isolate what worked. It also causes new problems. |
| "I see the problem, let me fix it" | Seeing the symptom is not understanding the root cause. |
| "One more fix attempt" (after 2+ failures) | 3+ failures = structural problem. Question the approach, don't patch again. |

## Quick Reference

| Phase | Key Activities | Success Criteria |
|-------|---------------|------------------|
| **1. Root Cause** | Read evidence, reproduce, check changes, instrument handoffs | Understand WHAT and WHY |
| **2. Pattern** | Find working examples, compare | Identify differences |
| **3. Hypothesis** | Form theory, test minimally | Confirmed or new hypothesis |
| **4. Implementation** | Define success test, fix, verify | Problem resolved, nothing else broken |

## When the Process Reveals "No Root Cause"

If systematic investigation shows the problem was genuinely external, timing-dependent, or one-off:

1. Document what you investigated and ruled out.
2. Put appropriate handling in place (monitoring check, early-warning signal, contingency plan).
3. Make the evidence easy to find if it recurs.

**But:** 95% of "no root cause" cases are incomplete investigation.

## Supporting Techniques

- **`root-cause-tracing.md`** — Trace problems backward through the chain of events to find the original trigger.
- **`defense-in-depth.md`** — Add checkpoints at every handoff so a failure can't cascade silently.

**Related skills:**
- **`verification-before-completion`** — Verify the fix actually worked before declaring success.
- **`systematic-debugging`** (software tasks only) — Phase 1 instrumentation patterns for code.
- **`self-consistency-reasoner`** — Invoked during Phase 3 (hypothesis testing) when multiple competing hypotheses exist and the problem is genuinely ambiguous. Generates independent reasoning paths from different starting points in the causal chain, then majority-votes to identify the most likely root cause.
