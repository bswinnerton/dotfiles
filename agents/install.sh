#!/bin/sh
# Agent configuration (Claude Code, Codex: instructions, memory, skills, hooks,
# MCP servers) lives in a separate private repository cloned to ~/.agents.

if ! command -v codex >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
  npm install -g @openai/codex
fi

if [ -x ~/.agents/install ]; then
  ~/.agents/install
else
  echo "  ~/.agents not found; skipping agent configuration"
fi
