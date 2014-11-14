# Pretty colors for ls
alias ls="ls -G"

# Set custom PS1
PS1='\[\e[0;32m\]\u@\h:\[\e[0;34m\]\w\[\033[1;31m\]♥\[\e[0m\] '

# rbenv requirement
eval "$(rbenv init -)"

# rvm requirement
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Create aliases, exports and rails environment variables
source $HOME/.aliases
source $HOME/.exports
source $HOME/.functions

# Automatically start tmux if installed
if which tmux &> /dev/null && [[ "$TERM" != "screen" ]]; then
  WHOAMI=$(whoami)
  if tmux has-session -t $WHOAMI 2>/dev/null; then
    tmux -2 attach-session -t $WHOAMI
  else
    tmux -2 new-session -s $WHOAMI
  fi
fi

# Fix SSD symbolic link bug
#
# This is only used for when you have two hard drives on a mac, with the home
# folder split on two
#PREFIX="/Volumes/Storage/Users/brooks/"
#PWD=`pwd`
#
#[[ ${PWD} =~ ${PREFIX}* ]] && cd ~/"${PWD#${PREFIX}}"
