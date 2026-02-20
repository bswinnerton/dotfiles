#!/bin/sh

mkdir -p ~/.claude

if [ ! -f ~/.claude/settings.json ]; then
  ln -s ~/.dotfiles/claude/settings.json ~/.claude/settings.json
fi
