#!/usr/bin/env bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

OS="`uname -s`"
if [ $OS = "Darwin" ]; then
  echo "Installing Homebrew."

  if [[ `uname -m` == 'arm64' ]]; then
    sudo mkdir -p /opt/homebrew/sbin/
    sudo chown -R $(whoami) /opt/homebrew/sbin
  else
    sudo mkdir -p /usr/local/homebrew/sbin/
    sudo chown -R $(whoami) /usr/local/homebrew/sbin
  fi

  # Install Brew if it's not already installed
  if ! [ -x "$(command -v brew)" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Install dependencies defined in Brewfile
  brew update

  BREWFILE="$HOME/.dotfiles/homebrew/Brewfile"
  failed=()

  while IFS= read -r line; do
    # Skip blank lines and comments
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    # Extract the package name (e.g. "brew 'git'" -> "git")
    pkg=$(echo "$line" | sed "s/^brew '//;s/'.*//")

    if brew ls --versions "$pkg" > /dev/null 2>&1; then
      echo "Using $pkg"
    else
      echo "Installing $pkg"
      if ! brew install "$pkg" 2>&1; then
        echo "  ⚠ $pkg failed to install, trying with --force --overwrite..."
        if ! brew install "$pkg" --force 2>&1; then
          if ! brew link --overwrite "$pkg" 2>&1; then
            echo "  ✗ $pkg could not be installed or linked"
            failed+=("$pkg")
          fi
        fi
      fi
    fi
  done < "$BREWFILE"

  if [ ${#failed[@]} -gt 0 ]; then
    echo ""
    echo "The following packages failed to install:"
    printf "  - %s\n" "${failed[@]}"
    echo "You may need to resolve these manually."
  fi
fi
