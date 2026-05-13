# Comparison to superpowers

austinpowers is a combination of [superpowers-optimized](https://github.com/REPOZY/superpowers-optimized) (software engineering workflows) and [normalpowers](https://github.com/fastxyz/normalpowers) (knowledge-work workflows). The original insight — "before you act, check which skill applies" — comes entirely from Jesse Vincent's superpowers project, and the skills we kept are in most cases light edits over the ones he wrote. We are grateful the project exists and grateful it is MIT-licensed.

austinpowers is what you get when you take that insight, keep all the software engineering machinery from superpowers-optimized, and add the knowledge-work skills from normalpowers.

## Skill-by-skill

### From superpowers-optimized (software engineering)

| superpowers | austinpowers | Notes |
|---|---|---|
| `using-superpowers` | `using-austinpowers` | Renamed. Entry-point covers both software and knowledge-work routing. |
| `brainstorming` | `brainstorming` | Same structure. Examples cover both product/strategy and software design. |
| `writing-plans` | `writing-plans` | Same structure. Plans cover code tasks, memo sections, and research steps. |
| `executing-plans` | `executing-plans` | Kept as-is from superpowers-optimized. |
| `systematic-debugging` | `systematic-debugging` | Four phases kept verbatim. Scoped to software/technical diagnosis. |
| `test-driven-development` | `test-driven-development` | Kept as-is. |
| `subagent-driven-development` | `subagent-driven-development` | Kept as-is; also applicable to knowledge-work parallel tasks. |
| `requesting-code-review` | `requesting-code-review` | Kept as-is. |
| `dispatching-parallel-agents` | `dispatching-parallel-agents` | Kept as-is. |
| `finishing-a-development-branch` | `finishing-a-work-unit` | Generalized slightly to cover non-code work units. |
| `verification-before-completion` | `verification-before-completion` | Same directory name. Works for both code and knowledge-work. |
| `writing-skills` | `writing-skills` | Same directory name. The meta-skill is domain-neutral already. |
| `context-management` | `context-management` | Kept as-is. |
| `refactoring` | `refactoring` | Kept as-is. |
| `performance-investigation` | `performance-investigation` | Kept as-is. |
| `frontend-design` | `frontend-design` | Kept as-is. |
| `dependency-management` | `dependency-management` | Kept as-is. |
| `error-recovery` | `error-recovery` | Kept as-is. |
| `premise-check` | `premise-check` | Kept as-is. |
| `deliberation` | `deliberation` | Kept as-is. |
| `self-consistency-reasoner` | `self-consistency-reasoner` | Kept as-is. |
| `token-efficiency` | `token-efficiency` | Kept as-is. |

### From normalpowers (knowledge work)

| normalpowers | austinpowers | Why different |
|---|---|---|
| `using-normalpowers` | (merged into `using-austinpowers`) | Knowledge-work routing merged into the unified entry point. |
| `following-your-plan` | `following-your-plan` | Kept. De-emphasizes software connotation. |
| `systematic-problem-solving` | `systematic-problem-solving` | Kept. Four phases with knowledge-work examples. |
| `receiving-feedback` | `receiving-feedback` | Kept. Covers manager feedback, peer review, pushback on decisions. |

## Structural differences from superpowers-optimized

austinpowers retains all of superpowers-optimized's structural machinery:

- Plugin manifest (`.claude-plugin/plugin.json`)
- Hook system (`hooks/session-start`, `hooks/stop-reminders.js`, safety hooks)
- Skill tool wiring
- Subagent orchestration support
- Tool environment assumptions (shell, editor, git, tests)

It adds the normalpowers knowledge-work skills as first-class citizens alongside the software skills. The `using-austinpowers` routing skill dispatches to either axis depending on what the user is doing.

## Structural differences from normalpowers

normalpowers is plain markdown by design — no plugin manifest, no hooks, no Skill tool, no subagents. It works on any LLM front-end via copy-paste.

austinpowers drops the portability constraint. It requires Claude Code and benefits from the full plugin infrastructure. The tradeoff: richer automation and better routing, at the cost of platform lock-in.

## Recommendation

**If you are doing knowledge work on Claude Code and also write software**, austinpowers is the right choice. Both skill sets are available in one plugin.

**If you need portability across ChatGPT, Gemini, and other platforms**, use [normalpowers](https://github.com/fastxyz/normalpowers) instead — plain markdown, any front-end.

**If you are doing software-only work and don't need knowledge-work skills**, [superpowers-optimized](https://github.com/REPOZY/superpowers-optimized) is a leaner option.
