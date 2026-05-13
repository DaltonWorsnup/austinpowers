#!/usr/bin/env bash
# bump-version.sh — bump austinpowers version across all manifest files
#
# Usage:
#   ./scripts/bump-version.sh 1.2.3
#
set -euo pipefail

NEW_VERSION="${1:-}"

if [ -z "${NEW_VERSION}" ]; then
  echo "Usage: $0 <new-version>"
  echo "Example: $0 1.2.3"
  exit 1
fi

# Validate semver-ish format
if ! [[ "${NEW_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: version must be in X.Y.Z format (got: ${NEW_VERSION})"
  exit 1
fi

echo "Bumping austinpowers to v${NEW_VERSION}..."

# ── package.json ─────────────────────────────────────────────────────────────
if [ -f "package.json" ]; then
  node -e "
    const fs = require('fs');
    const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    pkg.version = '${NEW_VERSION}';
    fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
  "
  echo "  Updated package.json"
fi

# ── .claude-plugin/plugin.json ───────────────────────────────────────────────
if [ -f ".claude-plugin/plugin.json" ]; then
  node -e "
    const fs = require('fs');
    const plugin = JSON.parse(fs.readFileSync('.claude-plugin/plugin.json', 'utf8'));
    plugin.version = '${NEW_VERSION}';
    fs.writeFileSync('.claude-plugin/plugin.json', JSON.stringify(plugin, null, 2) + '\n');
  "
  echo "  Updated .claude-plugin/plugin.json"
fi

# ── .claude-plugin/marketplace.json ─────────────────────────────────────────
if [ -f ".claude-plugin/marketplace.json" ]; then
  node -e "
    const fs = require('fs');
    const mkt = JSON.parse(fs.readFileSync('.claude-plugin/marketplace.json', 'utf8'));
    mkt.version = '${NEW_VERSION}';
    fs.writeFileSync('.claude-plugin/marketplace.json', JSON.stringify(mkt, null, 2) + '\n');
  "
  echo "  Updated .claude-plugin/marketplace.json"
fi

# ── .cursor-plugin/plugin.json ───────────────────────────────────────────────
if [ -f ".cursor-plugin/plugin.json" ]; then
  node -e "
    const fs = require('fs');
    const plugin = JSON.parse(fs.readFileSync('.cursor-plugin/plugin.json', 'utf8'));
    plugin.version = '${NEW_VERSION}';
    fs.writeFileSync('.cursor-plugin/plugin.json', JSON.stringify(plugin, null, 2) + '\n');
  "
  echo "  Updated .cursor-plugin/plugin.json"
fi

# ── .codex-plugin/plugin.json ────────────────────────────────────────────────
if [ -f ".codex-plugin/plugin.json" ]; then
  node -e "
    const fs = require('fs');
    const plugin = JSON.parse(fs.readFileSync('.codex-plugin/plugin.json', 'utf8'));
    plugin.version = '${NEW_VERSION}';
    fs.writeFileSync('.codex-plugin/plugin.json', JSON.stringify(plugin, null, 2) + '\n');
  "
  echo "  Updated .codex-plugin/plugin.json"
fi

# ── VERSION file ─────────────────────────────────────────────────────────────
if [ -f "VERSION" ]; then
  echo "${NEW_VERSION}" > VERSION
  echo "  Updated VERSION"
fi

echo ""
echo "Done. Verify with: grep -r '\"version\"' .claude-plugin/ .cursor-plugin/ .codex-plugin/ package.json 2>/dev/null"
