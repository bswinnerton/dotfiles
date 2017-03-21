#!/bin/sh

# Link Launchbar Actions to dotfiles
if ! [ -f ~/Library/Application\ Support/LaunchBar/Actions ]; then
  echo "Creating alias to Launchbar actions in dotfiles"
  mv ~/Library/Application\ Support/LaunchBar/Actions ~/Library/Application\ Support/LaunchBar/Old\ Actions
  ln -s ~/.dotfiles/launchbar ~/Library/Application\ Support/LaunchBar/Actions
  ln -s ~/.dotfiles/launchbar/snippets ~/Library/Application\ Support/LaunchBar/Snippets
fi
