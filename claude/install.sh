#!/bin/sh

mkdir -p ~/.claude

if [ ! -f ~/.claude/settings.json ]; then
  ln -s ~/.dotfiles/claude/settings.json ~/.claude/settings.json
fi

# Seed ~/.claude.json with preferences to skip onboarding flow
if [ ! -f ~/.claude.json ]; then
  cp ~/.dotfiles/claude/claude.json ~/.claude.json
fi
