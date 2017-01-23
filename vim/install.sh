#!/bin/sh

mkdir -p ~/.config/
if ! [ -f ~/.config/nvim ]; then
  ln -s ~/.dotfiles/vim/vim.symlink ~/.config/nvim
fi
