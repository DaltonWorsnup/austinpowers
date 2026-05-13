---
name: verification-before-completion
description: >
  Invoke BEFORE saying "done", "fixed", "ready", "shipped", or any completion
  claim. Requires fresh external evidence — no completion without proof.
  Applies to software tasks (command output, test results) and knowledge-work
  tasks (stakeholder confirmation, metric pulls, process observation).
  Also routed by using-austinpowers at task end.
---

# Verification Before Completion

Do not claim success without fresh external evidence.

**Core principle:** Internal belief that something worked is not evidence. Go look.

## The Gate

Before any completion claim:

1. Identify the observation that would prove this claim.
2. Go get that observation (run the command, ask the stakeholder, pull the metric, read the doc).
3. Inspect the full result — not a snippet.
4. State results exactly as observed.
5. **If the change includes a condition or gate that determines when something applies: explicitly state what it does NOT cover. If the answer reveals a gap, fix it before proceeding.**

## Applies To

- "Tests pass" / "Bug is fixed" / "Build succeeds" / "Ready to merge"
- "Done" / "Fixed" / "Ready" / "Shipped" / "Working"
- "Addresses the stakeholder's question" / "Memo was understood"
- ANY variation implying completion or correctness

## Not Acceptable (either domain)

- "Should pass" / "Should work" / "Looks good" / "I'm confident"
- Trusting old outputs or cached results
- Trusting subagent or third-party reports without independent verification

---

## Software Evidence Requirements

| Claim | Required Evidence |
|-------|------------------|
| Tests pass | Fresh command output with zero failures |
| Build succeeds | Successful exit code |
| Bug is fixed | Reproduction case now passes |
| Requirements met | Explicit checklist against plan |
| Feature works | Manual or automated smoke test |

### Stub Scan (code tasks)

When verifying completion of any task that created or modified production code:

```bash
grep -rn "TODO\|FIXME\|placeholder\|NotImplementedError" <src-dir> \
  --include="*.ts" --include="*.js" --include="*.py" --include="*.go" \
  | grep -v -i "test\|spec\|__tests__"
```

If any match falls in a file this task created or modified: the task is not done.

### Regression Test Verification

```
✅ Write test → Run (PASS) → Revert fix → Run (MUST FAIL) → Restore fix → Run (PASS)
❌ "I've written a regression test" (without red-green verification)
```

### Agent Delegation Verification

```
✅ Agent reports success → Check VCS diff → Verify changes match task → Report actual state
❌ Trust agent report at face value
```

---

## Knowledge-Work Evidence Requirements

| Claim | Required Evidence | Not Sufficient |
|-------|------------------|----------------|
| Deck answers the stakeholder's question | Stakeholder confirms in their own words | "It addresses the brief" |
| Memo was understood | Reader restates the key decision | "It's well written" |
| Process change landed | Observed behavior in the next cycle | Announcement sent |
| Metric moved | Fresh pull of the metric | "The change should lift it" |
| Offer accepted | Signed offer in hand | Verbal "I'm excited" |
| Requirements met | Line-by-line checklist against the brief | "Feels comprehensive" |
| Decision is approved | Approver said yes, in writing | Silence after you sent it |

---

## Self-Consistency Verification

When verification reasoning is non-trivial (multi-step inference, ambiguous evidence, configuration changes), apply multi-path reasoning before declaring the verdict:

1. Generate 3 independent reasoning paths evaluating: "Does this evidence actually prove the claim?"
2. Path A: what does the evidence prove? Path B: what does it NOT prove? Path C: alternative explanations for the output.
3. Majority-vote verdict:
   - All agree "verified": claim is proven.
   - Majority agrees, minority dissents: flag what the dissenting path identified.
   - No majority: evidence is insufficient. State what additional evidence is needed.

## Red Flags — STOP

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Done!", "Perfect!")
- Trusting a secondhand report as evidence
- Relying on partial verification
- "Just this once"

## The Rule

If evidence is missing, report current status as unverified and gather it.
