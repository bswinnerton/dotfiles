#!/bin/sh

config_dir=~/.config
config_file=$config_dir/alacritty/alacritty.yml

mkdir -p $config_dir

if [ ! -f "$config_file" ]; then
  echo "No Alacritty config found. Symlinking to dotfiles"
  ln -s ~/.dotfiles/alacritty "$config_dir"
fi
