# Brooks Swinnerton's Dot Files

## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive. Check out the [Rakefile](https://github.com/ryanb/dotfiles/blob/custom-bash-zsh/Rakefile) to see exactly what it does.

```
git clone https://github.com/bswinnerton/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rake install
```

Follow the prompts and enter the correct information. After installing, open a new terminal window to see the effects.

Feel free to customize the .zshrc file to match your preference.


## Uninstall

To remove the dotfile configs, run the following commands. Be certain to double check the contents of the files before removing so you don't lose custom settings.

```
unlink ~/.aliases
unlink ~/.bash_profile
unlink ~/.bashrc
unlink ~/.exports
unlink ~/.functions
unlink ~/.gemrc
unlink ~/.gitignore
unlink ~/.rspec
unlink ~/.screenrc
unlink ~/.tmux-powerlinerc
unlink ~/.tmux.conf
unlink ~/.vimrc
rm ~/.zshrc
rm ~/.gitconfig
rm -rf ~/.dotfiles
rm -rf ~/.oh-my-zsh
rm -rf ~/.vim
chsh -s /bin/bash # change back to bash if you want
```

Then open a new terminal window
