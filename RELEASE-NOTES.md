# Release Notes

## v1.0.0 (2026-05-13)

Initial release of austinpowers — a combined workflow plugin merging superpowers-optimized and normalpowers.

### New skills
- `using-austinpowers` — unified entry router for all task types
- `task-routing` — classifies tasks as software / knowledge-work / hybrid

### Combined from superpowers-optimized
19 skills: systematic-debugging, test-driven-development, executing-plans, subagent-driven-development (generalized), dispatching-parallel-agents (generalized), requesting-code-review, refactoring, frontend-design, performance-investigation, dependency-management, finishing-a-work-unit (generalized from finishing-a-development-branch), using-git-worktrees (generalized), claude-md-creator (generalized), self-consistency-reasoner (generalized), verification-before-completion (merged), brainstorming (merged), writing-plans (merged), context-management, error-recovery

### Combined from normalpowers
4 skills: following-your-plan, systematic-problem-solving, writing-skills, receiving-feedback (merged with receiving-code-review)

### Cross-domain generalizations
Six skills previously software-only were generalized for knowledge-work use: subagent-driven-development, dispatching-parallel-agents, finishing-a-work-unit, using-git-worktrees, claude-md-creator, self-consistency-reasoner

### Shared/merged skills
- `brainstorming` — unified with domain-specific sections (software + knowledge-work)
- `writing-plans` — unified with two task templates (software + knowledge-work)
- `verification-before-completion` — merged evidence tables for both domains
- `receiving-feedback` — merged from receiving-code-review + normalpowers receiving-feedback

### Attribution
Based on superpowers (Jesse Vincent), superpowers-optimized (Jesse Vincent / REPOZY), and normalpowers (Jesse Vincent / Pi Squared Inc.).
