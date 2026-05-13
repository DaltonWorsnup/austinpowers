---
name: finishing-a-work-unit
description: >
  MUST USE when work is verified and you need to choose the outcome: integrate,
  publish, keep, or discard. For software: merge, PR, keep branch, or discard.
  For knowledge-work: send/publish, save draft, archive, or discard.
  Triggers on: "we're done", "merge this", "create a PR", "publish this",
  "send this", "clean up", "what do we do with this", after
  verification-before-completion passes. Routed by using-austinpowers
  or executing-plans / following-your-plan at completion.
---

# Finishing a Work Unit

Close completed work with an explicit integration or publication choice.

## Step 1: Verify

Run full verification before offering options. If verification fails, stop and return to implementation.

For software: re-run tests, build, and linter.
For knowledge-work: confirm requirements are met and the intended audience/stakeholder is ready.

## Step 2: Determine Domain

Is this a software task (code, configuration, branch) or a knowledge-work task (document, memo, analysis, decision)?

- **Software → go to Software Options**
- **Knowledge-work → go to Knowledge-Work Options**

---

## Software Options

### Identify Base Branch

Detect merge base (`main`/`master` or repo default) and confirm if unclear.

### Offer Exactly Four Options

1. Merge back to `<base-branch>` locally
2. Push branch and open PR
3. Keep branch/worktree as-is
4. Discard branch/worktree

### Execute Safely

**Option 1: Local merge**
- Checkout base
- Pull latest
- Merge feature branch
- Re-run verification
- Delete merged branch
- Remove worktree

**Option 2: Push and open PR**
- Push feature branch
- Create PR with a description that includes:
  - **What changed** — one-paragraph summary
  - **Why** — motivation or problem this solves (link to plan doc if one exists)
  - **How to verify** — exact commands or steps a reviewer can run
  - **Notable decisions** — trade-offs made, alternatives rejected, non-obvious choices.
    If `session-log.md` has `[saved]` entries from this branch's lifetime, extract the Decisions and Rejected bullets from the most recent entry.
- Keep worktree by default (remove only if user asks)

**Option 3: Keep branch and worktree**
- Report exact path and branch name

**Option 4: Discard**
- Show destructive impact summary
- Require exact confirmation: `discard`
- Delete branch and remove worktree

### Software Hard Rules

- Never merge with failing tests.
- Never delete work without explicit confirmation.
- Never force-push unless explicitly requested.

---

## Knowledge-Work Options

### Identify Destination

Where does this work need to go? Options depend on what was built:
- A document, memo, or brief → publish/send or save as draft
- An analysis or research report → share with stakeholder or archive
- A decision record → file it or communicate it
- Any work unit → discard if no longer needed

### Offer Exactly Four Options

1. **Publish / Send** — deliver to the intended audience (send the email, share the doc, post to the channel, file the record)
2. **Save as Draft** — preserve the work without delivering (keep in drafts, mark as in-progress, save locally)
3. **Archive** — preserve for reference without active use (move to archive folder, mark completed but not delivered)
4. **Discard** — delete or abandon the work

### Execute Safely

**Option 1: Publish / Send**
- Confirm the audience and delivery method with the user
- Confirm the work has been verified (verification-before-completion was run)
- Execute delivery
- Record the send/publish event in `session-log.md` if it constitutes a significant decision

**Option 2: Save as Draft**
- Confirm file location or draft folder
- Save with a clear name: `YYYY-MM-DD-<topic>-DRAFT.md` or equivalent
- Report the saved path

**Option 3: Archive**
- Move to archive location or add a clear "ARCHIVED - YYYY-MM-DD" header
- Report the archive location

**Option 4: Discard**
- Show what will be lost
- Require explicit confirmation
- Proceed only after confirmation

### Knowledge-Work Hard Rules

- Never publish or send without explicit user confirmation of the recipient.
- Never discard work without explicit confirmation.
- If work has been shared with stakeholders, do not silently delete the source.

---

## Final Report

Include:
- Selected option
- Actions executed
- Final status (merged, sent, saved at path, archived at path, discarded)
- PR link or document link if applicable
