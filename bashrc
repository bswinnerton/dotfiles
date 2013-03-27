# Pretty colors for ls
alias ls="ls -G"

# Set custom PS1
PS1='\[\e[0;32m\]\u@\h:\[\e[0;34m\]\w\[\033[1;31m\]♥\[\e[0m\] '

export PATH="/usr/local/heroku/bin:$PATH"

if [ -f ~/.rails-env-variables/ ]; then 
  source $HOME/.rails-env-variables/* 
fi
source $HOME/.aliases
source $HOME/.exports
  
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # To load rvm into shell

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
