# Sets up Neovim config directories

if [ -d ~/.config/nvim ]; then
  ln -s ~/.vim ~/.config/nvim
fi

if [ -d ~/.config/nvim/init.vim ]; then
  ln -s ~/.vimrc ~/.config/nvim/init.vim
fi
