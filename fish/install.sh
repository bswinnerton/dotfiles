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
current_shell=$(dscl . -read /Users/"$current_user" UserShell 2>/dev/null | awk '{print $2}')

#FIXME: Suppress the $fish_path from being outputted on the screen
#grep -qF "fish" /etc/shells || echo $fish_path | sudo tee -a /etc/shells

if [ "$current_shell" != "$fish_path" ]; then
  chsh -s "$fish_path" "$current_user" || true
fi

unset current_user fish_path current_shell
