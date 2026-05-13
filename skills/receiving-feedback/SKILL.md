---
name: receiving-feedback
description: >
  Use when receiving feedback on your work — code review comments, document
  critique, exec pushback, stakeholder objections, peer review — before
  changing anything. Requires verification and reasoning, not performative
  agreement or blind compliance.
---

# Receiving Feedback

Treat feedback as input to evaluate, not as instructions to follow blindly.

**Core principle:** Verify before revising. Ask before assuming. Correctness over social comfort. Separate the reviewer's frustration from the reviewer's points.

## The Response Pattern

```
1. READ: Absorb the full set of feedback without reacting
2. CLARIFY: Resolve unclear items before touching anything
3. VALIDATE: Check each suggestion against the work, codebase/document, and requirements
4. EVALUATE: Is this point correct for THIS work, this audience, this goal?
5. RESPOND: Substantive acknowledgment or reasoned pushback
6. REVISE: One item at a time; re-read/re-test each change in context
```

## Forbidden Responses

**Never say:**
- "You're absolutely right!"
- "Great point!" / "Excellent feedback!" / "Good catch!"
- "Thanks for catching that!" / any gratitude expression before analysis
- Any agreement before verification

**Instead:** state what you verified, what you changed, and why. If the reviewer is right, the change speaks for itself.

## Handling Unclear Feedback

If any item is unclear: **STOP — do not revise anything yet.** Ask for clarification on the unclear items.

Why: items may be related. Partial understanding produces the wrong revision. Three comments are often one underlying concern in three costumes — fix the wrong one and the other two get louder.

**Example:**
```
Reviewer: "Address items 1–6."
You understand 1, 2, 3, 6. Unclear on 4 and 5.

WRONG: Revise 1, 2, 3, 6 now and ask about 4, 5 later.
RIGHT: "I understand 1, 2, 3, 6. I need clarification on 4 and 5 before
       revising — 4 may change how I handle 2."
```

## Priority Order

1. Correctness / security issues (code) or factual errors (documents) — blocking
2. Requirement mismatches or wrong recommendation
3. Maintainability / structural issues
4. Minor polish, typos, formatting

## Pushback Rules

Push back when a suggestion:
- Breaks existing behavior or makes the work less accurate
- Conflicts with approved architecture or decisions already agreed with your human partner
- Adds unused scope (YAGNI) — weight the work down without serving the audience
- Lacks enough context to verify
- Reflects the reviewer's preference, not the goal of the work
- The reviewer is venting frustration — address the frustration separately; don't contort the work around it

**How to push back:** use concrete technical evidence or explicit reasoning, not opinions. Reference the goal, the audience, or prior agreed decisions.

**For code review specifically:** pushback must include concrete technical evidence — code or test output, not "I think" or "it should be fine."

## Revision Order

1. Clarify anything unclear FIRST
2. Then revise: blocking issues → simple fixes → structural fixes
3. Re-read/re-test each revision in surrounding context
4. Check you haven't broken cohesion elsewhere

## YAGNI Check for "Make It More Thorough" Feedback

Reviewers often push for added sections, extra scenarios, more caveats. Before piling on:

```
IF reviewer suggests "cover this properly" / "add a full section on X":
  Check: Does the audience actually need this to make the decision?
  IF no: "The audience doesn't need this to act. Adding it buries the main point."
  IF yes: Add it, tightly.
```

## Acknowledging Correct Feedback

When feedback IS correct:

```
GOOD:
  "Fixed. [Brief description of what changed]"
  "Good catch — [specific issue]. Revised in [section/file]."
  [Just fix it; the revised work speaks for itself]

AVOID:
  "You're absolutely right!" / "Great point!" / any performative gratitude
```

## When to Escalate

- Feedback conflicts with decisions already agreed with your human partner → stop, discuss with partner first
- Disagreement is about direction, not detail → escalate
- Reviewer is working from incomplete context → explain the context, then decide

## Red Flags

- "I'll just make the change; it's easier than arguing."
- "They're senior, so they must be right."
- "I'll fix the wording even though the point is wrong — splitting the difference."
- "I feel attacked, so I'll agree to end the conversation."
- "Three people said it, so it must be right." (Three people reading the same confusing sentence produce three versions of the same wrong diagnosis.)

## Completion (software tasks)

After addressing all feedback, report:
- Addressed items
- Deferred items with reason
- Verification commands/results
- Remaining risks
