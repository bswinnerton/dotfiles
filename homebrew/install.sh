#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

echo "Installing Homebrew for you."

sudo mkdir -p /usr/local/sbin/
sudo chown -R $(whoami) /usr/local/sbin

# Install the correct homebrew for each OS type
if [[ "$(uname -s)" = "Darwin" ]]
then
  # Install Brew if it's not already installed
  if ! [ -x "$(command -v brew)" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Install dependencies defined in Brewfile
  brew tap Homebrew/bundle
  brew update
  brew bundle --file="$HOME/.dotfiles/homebrew/Brewfile"
  brew bundle --file="$HOME/.dotfiles/homebrew/Brewfile.darwin"

elif [[ "$(expr substr $(uname -s) 1 5)" = "Linux" ]]
then
  # Install brew dependencies
  sudo apt-get install -y build-essential gcc ruby zlib1g-dev libxslt1-dev

  # Install Brew if it's not already installed
  if ! [ -x "$(command -v brew)" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
  fi

  # Add Linuxbrew to bash path if it doesn't already exist
  if ! [ $(grep -q ".linuxbrew/bin" "$HOME/.bash_profile") ]; then
    echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> $HOME/.bash_profile
    source $HOME/.bash_profile
  fi

  # FIXME: Parse the Brewfile manually until homebrew-bundle has Linux support
  HOMEBREW_PATH=$HOME/.dotfiles/homebrew
  ruby -e "File.foreach(\"$HOMEBREW_PATH/Brewfile.linux\") { |l| l.gsub!('brew', 'brew install'); system(\"brew #{l}\") }"
  ruby -e "File.foreach(\"$HOMEBREW_PATH/Brewfile\") { |l| l.gsub!('brew', 'brew install'); system(\"brew #{l}\") }"
  unset HOMEBREW_PATH

fi

exit 0
