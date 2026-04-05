#!/bin/sh

mkdir -p ~/.codex

if ! command -v codex >/dev/null 2>&1; then
  npm install -g @openai/codex
fi

if [ ! -f ~/.codex/config.toml ]; then
  ln -s ~/.dotfiles/codex/config.toml ~/.codex/config.toml
fi
