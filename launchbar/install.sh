#!/bin/sh

# Link Launchbar Actions to dotfiles
if ! [ -f ~/Library/Application\ Support/LaunchBar/Actions ]; then
  ln -s ~/.dotfiles/launchbar ~/Library/Application\ Support/LaunchBar/Actions
fi
