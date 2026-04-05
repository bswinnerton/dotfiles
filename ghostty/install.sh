#!/bin/sh

config_dir=~/.config
config_file=$config_dir/ghostty

if [ ! -e "$config_file" ]; then
  mkdir -p $config_dir

  if [ ! -e "$config_file" ]; then
    echo "No Ghostty config found. Symlinking to dotfiles"
    ln -s ~/.dotfiles/ghostty "$config_file"
  fi
fi
