# austinpowers

A combined workflow plugin for Claude Code that covers both **software engineering** and **knowledge work**. It merges [`superpowers-optimized`](https://github.com/REPOZY/superpowers-optimized) (engineering workflows) with [`normalpowers`](https://github.com/fastxyz/normalpowers) (knowledge-work workflows) into one coherent plugin — yeah, baby.

## What it does

austinpowers gives Claude Code a disciplined workflow for any type of task:

- **Software engineering mode**: TDD, systematic debugging, code review, refactoring, frontend design, subagent-driven development, branch management, performance investigation, dependency management.
- **Knowledge-work mode**: Brainstorming before producing, structured planning, following-your-plan execution, systematic problem-solving, verification before claims, rigorous feedback handling.
- **Hybrid mode**: Technical writing, architecture design, data analysis, product strategy, and anything that blends code and organizational thinking.

The plugin automatically routes tasks to the right workflow via the `task-routing` skill.

## Installation

The plugin marketplace is bundled in this repo. Add it once, then install:

```
/plugin marketplace add DaltonWorsnup/austinpowers
/plugin install austinpowers@austinpowers
```

Or clone and install locally:

```bash
git clone https://github.com/DaltonWorsnup/austinpowers
/plugin install ./austinpowers
```

## How it works

Every session starts with `using-austinpowers` loaded automatically via the SessionStart hook. The skill:

1. Classifies your task as micro, lightweight, or full complexity.
2. Routes it to the right domain (software, knowledge-work, or hybrid) via `task-routing`.
3. Selects the appropriate skill pipeline.

For software tasks, the pipeline mirrors `superpowers-optimized`: brainstorm → plan → execute (subagent-driven) → verify → finish work unit.

For knowledge-work tasks, the pipeline mirrors `normalpowers`: brainstorm → write-plans → follow-your-plan → verify → finish work unit.

## Skills

### Routing & Core
| Skill | Purpose |
|-------|---------|
| `using-austinpowers` | Entry router for all tasks |
| `task-routing` | Classifies tasks as software / knowledge-work / hybrid |
| `token-efficiency` | Always-on: concise responses, parallel tool calls, context hygiene |
| `brainstorming` | Design approval before any work begins |
| `writing-plans` | Decompose approved designs into executable task plans |
| `verification-before-completion` | Evidence required before any completion claim |
| `receiving-feedback` | Handle review feedback or stakeholder pushback with rigor |
| `premise-check` | Validate that the work is worth doing before designing |
| `deliberation` | Surface competing perspectives before brainstorming |
| `context-management` | Cross-session state: project-map, session-log, state.md |
| `error-recovery` | Track known error→solution mappings |
| `writing-skills` | Author new skills for your own domain |
| `self-consistency-reasoner` | Multi-path majority-vote reasoning for high-stakes inference (internal) |

### Cross-Domain Execution
These skills were written for software engineering but apply equally to knowledge-work. `subagent-driven-development` and `dispatching-parallel-agents` handle parallel execution for any output type; `finishing-a-work-unit` covers publishing/merging/archiving for any deliverable; `using-git-worktrees` covers both branch isolation and document draft isolation; `claude-md-creator` creates context files for both software repos and knowledge-work projects.

| Skill | Purpose |
|-------|---------|
| `subagent-driven-development` | Parallel subagents with staged compliance + quality review gates |
| `dispatching-parallel-agents` | Independent concurrent tasks (code, research, analysis) |
| `finishing-a-work-unit` | Merge / publish / archive / discard decisions for any deliverable |
| `using-git-worktrees` | Isolated branch development (software) and draft isolation (knowledge-work) |
| `claude-md-creator` | Initialize CLAUDE.md / AGENTS.md (software) or CONTEXT.md / PROJECT.md (knowledge-work) |

### Software Engineering
| Skill | Purpose |
|-------|---------|
| `executing-plans` | Execute code plans with verification checkpoints |
| `test-driven-development` | RED → GREEN → REFACTOR cycle |
| `systematic-debugging` | Root cause investigation for code failures |
| `requesting-code-review` | Multi-phase code review with security checklist |
| `refactoring` | Behavior-locked incremental restructuring |
| `frontend-design` | Production-grade UI with Tailwind v4, accessibility |
| `performance-investigation` | Profile → identify → fix → re-measure |
| `dependency-management` | Incremental dependency updates with verification |

### Knowledge Work
| Skill | Purpose |
|-------|---------|
| `following-your-plan` | Execute knowledge-work plans with explicit deviation tracking |
| `systematic-problem-solving` | Root cause investigation for org/process problems |

## Attribution

austinpowers is a derivative of:
- [superpowers](https://github.com/obra/superpowers) by Jesse Vincent (MIT)
- [superpowers-optimized](https://github.com/REPOZY/superpowers-optimized) by Jesse Vincent / REPOZY (MIT)
- [normalpowers](https://github.com/fastxyz/normalpowers) by Jesse Vincent / Pi Squared Inc. (MIT)

See [NOTICE](NOTICE) for full attribution.

## License

MIT — see [LICENSE](LICENSE).
