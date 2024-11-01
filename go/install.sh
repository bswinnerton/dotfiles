#!/bin/sh

if ! which go > /dev/null 2>&1; then
  mkdir -p "$HOME/go/bin"

  OS="`uname -s`"
  if [ "$OS" = "Darwin" ]; then
    brew install golang
  else
    sudo apt-get update
    sudo apt-get -y install golang
  fi
fi
