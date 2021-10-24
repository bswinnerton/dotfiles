#!/bin/sh

OS="`uname -s`"
if [ "$OS" == "Darwin" ]; then
  base_path=~/Library/Application\ Support/LaunchBar

  snippets_path=$base_path/Snippets
  actions_path=$base_path/Actions

  # Check to see if snippets directory exists and hasn't been previously symlinked
  if [ -d "$snippets_path" ] && [ ! -L "$snippets_path" ]; then
    echo "Found stock Snippets directory, backing up and symlinking dotfiles"
    mv "$snippets_path" "$snippets_path"-backup
    ln -s ~/.dotfiles/launchbar/Snippets "$snippets_path"
  fi

  # Check to see if actions directory exists and hasn't been previously symlinked
  if [ -d "$actions_path" ] && [ ! -L "$actions_path" ]; then
    echo "Found stock Actions directory, backing up and symlinking dotfiles"
    mv "$actions_path" "$actions_path"-backup
    ln -s ~/.dotfiles/launchbar/Actions "$actions_path"
  fi
fi
