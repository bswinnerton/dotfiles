#!/bin/sh

if [ ! -f "$HOME/.cargo/bin/rustc" ]; then
  echo "Installing Rust"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
fi
