#!/usr/bin/env bash
set -euo pipefail

VERSION=$(node -e "console.log(require('./package.json').version)")
DIST_DIR="dist"
mkdir -p "${DIST_DIR}"

# ── zip ──────────────────────────────────────────────────────────────────────
build_zip() {
  local ZIP_NAME="austinpowers-v${VERSION}.zip"
  local STAGING
  STAGING="$(mktemp -d)"

  echo "Building ${ZIP_NAME}..."
  rm -f "${DIST_DIR}/austinpowers-v"*.zip

  rsync -a --exclude="graphviz-conventions.dot" --exclude="austinpowers.skill.md" skills/ "${STAGING}/skills/"

  cat > "${STAGING}/INDEX.md" << 'INDEXEOF'
# austinpowers — skill bundle index

You have the austinpowers skill bundle loaded as knowledge. Here is how to navigate it.

## Master prompt

Your operating instructions are in the custom instructions field — not in this knowledge bundle.
If you don't see a master prompt, ask the user to paste `austinpowers.md` into custom instructions.

## Skills

Skills live in `skills/<name>/SKILL.md`. When your master prompt says "read skill X"
or a skill references another, retrieve the file from this knowledge base.

| Skill | Path | Use when |
|---|---|---|
| `using-austinpowers` | `skills/using-austinpowers/SKILL.md` | Entry point — every conversation |
| `brainstorming` | `skills/brainstorming/SKILL.md` | Figuring out what to build, write, decide, or plan |
| `writing-plans` | `skills/writing-plans/SKILL.md` | Turning an approved spec into executable steps |
| `following-your-plan` | `skills/following-your-plan/SKILL.md` | Executing a knowledge-work plan task-by-task |
| `executing-plans` | `skills/executing-plans/SKILL.md` | Executing a software plan task-by-task |
| `systematic-debugging` | `skills/systematic-debugging/SKILL.md` | Diagnosing software bugs |
| `systematic-problem-solving` | `skills/systematic-problem-solving/SKILL.md` | Diagnosing knowledge-work problems |
| `test-driven-development` | `skills/test-driven-development/SKILL.md` | Writing tests before code |
| `verification-before-completion` | `skills/verification-before-completion/SKILL.md` | Verifying work before claiming done |
| `receiving-feedback` | `skills/receiving-feedback/SKILL.md` | Evaluating and responding to critique |
| `writing-skills` | `skills/writing-skills/SKILL.md` | Authoring new skills for your domain |
| `subagent-driven-development` | `skills/subagent-driven-development/SKILL.md` | Parallel subagent execution |
| `context-management` | `skills/context-management/SKILL.md` | Persistent memory across sessions |

## Supporting reference docs

Some skills have supporting reference documents in their folder. Retrieve these when the
parent skill instructs you to.

- `skills/systematic-debugging/root-cause-tracing.md` — referenced by `systematic-debugging`
- `skills/systematic-debugging/defense-in-depth.md` — referenced by `systematic-debugging`
- `skills/systematic-problem-solving/root-cause-tracing.md` — referenced by `systematic-problem-solving`
- `skills/systematic-problem-solving/defense-in-depth.md` — referenced by `systematic-problem-solving`
- `skills/writing-skills/anthropic-best-practices.md` — referenced by `writing-skills`
- `skills/writing-skills/persuasion-principles.md` — referenced by `writing-skills`
INDEXEOF

  (cd "${STAGING}" && zip -r "${OLDPWD}/${DIST_DIR}/${ZIP_NAME}" .)
  rm -rf "${STAGING}"

  echo "Contents of ${DIST_DIR}/${ZIP_NAME}:"
  unzip -l "${DIST_DIR}/${ZIP_NAME}"
}

# ── plugin ───────────────────────────────────────────────────────────────────
build_plugin() {
  local PLUGIN_NAME="austinpowers-v${VERSION}.plugin"
  local STAGING
  STAGING="$(mktemp -d)"

  echo "Building ${PLUGIN_NAME}..."
  rm -f "${DIST_DIR}/austinpowers-v"*.plugin

  cp .claude-plugin/plugin.json "${STAGING}/plugin.json"
  rsync -a hooks/ "${STAGING}/hooks/"
  rsync -a --exclude="graphviz-conventions.dot" --exclude="austinpowers.skill.md" skills/ "${STAGING}/skills/"
  cp austinpowers.md "${STAGING}/austinpowers.md"

  (cd "${STAGING}" && zip -r "${OLDPWD}/${DIST_DIR}/${PLUGIN_NAME}" .)
  rm -rf "${STAGING}"

  echo "Contents of ${DIST_DIR}/${PLUGIN_NAME}:"
  unzip -l "${DIST_DIR}/${PLUGIN_NAME}"
}

# ── skill ────────────────────────────────────────────────────────────────────
build_skill() {
  local SKILL_NAME="austinpowers-v${VERSION}.skill"
  local STAGING
  STAGING="$(mktemp -d)"

  echo "Building ${SKILL_NAME}..."
  rm -f "${DIST_DIR}/austinpowers-v"*.skill

  # The one SKILL.md — purpose-built entry point
  cp skills/austinpowers.skill.md "${STAGING}/SKILL.md"

  # Flatten each skill's SKILL.md as <skill-name>.md
  for dir in skills/*/; do
    local skill_name
    skill_name="$(basename "${dir}")"
    if [ -f "${dir}SKILL.md" ]; then
      cp "${dir}SKILL.md" "${STAGING}/${skill_name}.md"
    fi
  done

  # Support docs flat
  cp skills/systematic-debugging/root-cause-tracing.md "${STAGING}/systematic-debugging-root-cause-tracing.md"
  cp skills/systematic-debugging/defense-in-depth.md "${STAGING}/systematic-debugging-defense-in-depth.md"
  cp skills/systematic-problem-solving/root-cause-tracing.md "${STAGING}/root-cause-tracing.md"
  cp skills/systematic-problem-solving/defense-in-depth.md "${STAGING}/defense-in-depth.md"
  cp skills/writing-skills/anthropic-best-practices.md "${STAGING}/anthropic-best-practices.md"
  cp skills/writing-skills/persuasion-principles.md "${STAGING}/persuasion-principles.md"

  (cd "${STAGING}" && zip -r "${OLDPWD}/${DIST_DIR}/${SKILL_NAME}" .)
  rm -rf "${STAGING}"

  echo "Contents of ${DIST_DIR}/${SKILL_NAME}:"
  unzip -l "${DIST_DIR}/${SKILL_NAME}"
}

# ── main ─────────────────────────────────────────────────────────────────────
build_zip
echo ""
build_plugin
echo ""
build_skill
echo ""
echo "Done. All artifacts in ${DIST_DIR}/:"
ls -lh "${DIST_DIR}/austinpowers-v"*
