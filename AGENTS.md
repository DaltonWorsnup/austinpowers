# austinpowers plugin — agent context

See CLAUDE.md for contributor guidance. Key points for agents:

- Never edit files in `lib/` without checking all hook scripts that require them
- Never rename a skill directory without updating `hooks/skill-rules.json` and the README
- Skill `name:` in frontmatter is the invoke name; directory name is secondary
- The `hooks/session-start` bash script is load-bearing — test changes carefully
