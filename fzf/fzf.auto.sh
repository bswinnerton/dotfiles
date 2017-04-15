# Setup fzf
# ---------
if [[ ! "$PATH" == *$(brew --prefix)/opt/fzf/bin* ]]; then
  export PATH="$PATH:$(brew --prefix)/opt/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == *$(brew --prefix)/opt/fzf/man* && -d "$(brew --prefix)/opt/fzf/man" ]]; then
  export MANPATH="$MANPATH:$(brew --prefix)/opt/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# Configuration Options
# ---------------------
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-messages --glob '!.git/*'"
