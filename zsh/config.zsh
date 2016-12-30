# Allows for dynamic functions in prompt
setopt PROMPT_SUBST

# History
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY SHARE_HISTORY

# Emacs key bindings
bindkey -e

# Save history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Enable shift tab selection
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete
