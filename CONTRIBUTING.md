# Contributing to austinpowers

## Adding a skill

1. Create a directory under `skills/<skill-name>/`
2. Add `SKILL.md` with YAML frontmatter (`name:`, `description:`) and the skill body
3. Add an entry to `hooks/skill-rules.json` so the skill-activator can suggest it
4. Update the README skills table

## Editing existing skills

Keep skills concise — every line adds token cost at load time. Prefer routing tables over prose. Test with representative prompts.

## Hook changes

Changes to `hooks/` affect all sessions. Test carefully on both macOS/Linux and Windows (via `run-hook.cmd`).

## Pull requests

Open a PR against `main`. Include a short description of what changed and why.
