#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');

function getHomeDir() {
  return process.env.HOME || process.env.USERPROFILE || '.';
}

function readStdinSync() {
  try {
    return fs.readFileSync(0, 'utf8');
  } catch {
    return '';
  }
}

function readJsonStdin() {
  const raw = readStdinSync();
  if (!raw.trim()) return {};

  try {
    return JSON.parse(raw);
  } catch {
    return null;
  }
}

function readFileSafe(filePath) {
  try {
    return fs.readFileSync(filePath, 'utf8');
  } catch {
    return '';
  }
}

function getAustinpowersConfigDir() {
  if (process.env.XDG_CONFIG_HOME) {
    return path.join(process.env.XDG_CONFIG_HOME, 'austinpowers');
  }
  return path.join(getHomeDir(), '.config', 'austinpowers');
}

function parseBooleanLike(value) {
  if (typeof value !== 'string') return null;

  switch (value.trim().toLowerCase()) {
    case '1':
    case 'true':
    case 'yes':
    case 'on':
      return true;
    case '0':
    case 'false':
    case 'no':
    case 'off':
      return false;
    default:
      return null;
  }
}

function isAutoUpdateDisabled() {
  const envSetting = parseBooleanLike(process.env.AUSTINPOWERS_AUTO_UPDATE || '');
  if (envSetting !== null) return envSetting === false;

  const configPath = path.join(getAustinpowersConfigDir(), 'update.conf');
  const raw = readFileSafe(configPath);
  if (!raw) return false;

  for (const line of raw.split(/\r?\n/)) {
    const match = line.match(/^\s*auto_update\s*=\s*(.+?)\s*$/);
    if (!match) continue;

    const parsed = parseBooleanLike(match[1]);
    if (parsed !== null) return parsed === false;
  }

  return false;
}

module.exports = {
  getHomeDir,
  getAustinpowersConfigDir,
  isAutoUpdateDisabled,
  readFileSafe,
  readJsonStdin,
  readStdinSync,
};
