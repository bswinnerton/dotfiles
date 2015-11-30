#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

echo "  Installing Homebrew for you."

# Install the correct homebrew for each OS type
if test "$(uname -s)" = "Darwin"
then

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Install dependencies defined in Brewfile
  brew tap Homebrew/bundle
  brew bundle --file="$HOME/.dotfiles/homebrew/Brewfile"
  brew bundle --file="$HOME/.dotfiles/homebrew/Brewfile.darwin"

elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
then

  sudo apt-get install -y build-essential gcc ruby zlib1g-dev libxslt1-dev
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"

  # Add Linuxbrew to bash path if it doesn't already exist
  if ! [ $(grep -q ".linuxbrew/bin" "$HOME/.bash_profile") ]; then
    echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> $HOME/.bash_profile
    . $HOME/.bash_profile
  fi

  # FIXME: Parse the Brewfile manually until homebrew-bundle has Linux support
  HOMEBREW_PATH=$HOME/.dotfiles/homebrew
  ruby -e "File.foreach(\"$HOMEBREW_PATH/Brewfile.linux\") { |l| l.gsub!('brew', 'brew install'); system(\"brew #{l}\") }"
  ruby -e "File.foreach(\"$HOMEBREW_PATH/Brewfile\") { |l| l.gsub!('brew', 'brew install'); system(\"brew #{l}\") }"
  unset HOMEBREW_PATH

fi

exit 0
