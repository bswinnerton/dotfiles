#!/bin/sh

config_dir=~/.config
config_file=$config_dir/ghostty/alacritty.yml

if [ ! -f "$config_file" ]; then
  mkdir -p $config_dir

  if [ ! -f "$config_file" ]; then
    echo "No Ghostty config found. Symlinking to dotfiles"
    ln -s ~/.dotfiles/ghostty "$config_dir"
  fi
fi
