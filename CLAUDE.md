# austinpowers plugin — contributor context

## Skill format

Each skill lives at `skills/<name>/SKILL.md`. The YAML frontmatter `name:` field is the skill's invoke name. The `description:` is trigger-focused — it tells Claude when to invoke the skill.

## Adding skills

- Add `SKILL.md` in a new `skills/<name>/` directory
- Add a `skill-rules.json` entry in `hooks/` for keyword/pattern routing
- Update the README skills table

## Critical constraints

- `hooks/hooks.json` wires all hook events — edit it when adding new hooks
- `hooks/skill-rules.json` drives UserPromptSubmit skill activation hints
- `hooks/session-start` (bash) injects using-austinpowers + project memory at session start
- `lib/skills-core.js` is required by skill-activator.js and context-engine.js — do not delete it
- `hooks/run-hook.cmd` is a polyglot CMD/bash wrapper for cross-platform hook execution
- Skill directory names do not need to match the `name:` field in SKILL.md frontmatter (e.g., `claude-md-creator/` has `name: context-file-creator`)

## Testing hooks

Run `node hooks/skill-activator.js` from the plugin root with a test STDIN payload to verify rule matching.
