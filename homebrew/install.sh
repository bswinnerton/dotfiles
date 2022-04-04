#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

OS="`uname -s`"
if [ $OS = "Darwin" ]; then
  echo "Installing Homebrew."

  sudo mkdir -p /opt/homebrew/sbin/
  sudo chown -R $(whoami) /opt/homebrew/sbin

  # Install Brew if it's not already installed
  if ! [ -x "$(command -v brew)" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Install dependencies defined in Brewfile
  brew tap Homebrew/bundle
  brew update
  brew bundle --file="$HOME/.dotfiles/homebrew/Brewfile"
fi
