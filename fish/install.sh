#!/bin/sh

config_dir=~/.config
config_file=$config_dir/fish/config.fish

mkdir -p $config_dir

if [ ! -f "$config_file" ]; then
  rm -rf ~/.config/fish
  ln -s ~/.dotfiles/fish ~/.config
fi

current_user=$(whoami)
fish_path=$(which fish)

#FIXME: Suppress the $fish_path from being outputted on the screen
#grep -qF "fish" /etc/shells || echo $fish_path | sudo tee -a /etc/shells

chsh -s $fish_path $current_user

unset current_user fish_path
