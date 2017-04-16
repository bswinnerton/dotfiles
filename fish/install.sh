#!/bin/sh

config_file=~/.config/fish/config.fish

mkdir -p ~/.config/fish

if [ ! -L "$config_file" ]; then
  echo "No fish config found. Symlinking to dotfiles"
  ln -s ~/.dotfiles/fish/config.fish "$config_file"
fi

current_user=$(whoami)
fish_path=$(which fish)

#FIXME: Suppress the $fish_path from being outputted on the screen
grep -qF "fish" /etc/shells || echo $fish_path | sudo tee -a /etc/shells

sudo chsh -s $fish_path $current_user

unset current_user fish_path
