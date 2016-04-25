alias b="bundle"
alias be="bundle exec"
alias gist="gist -p"
alias gti="git"
alias ls="ls -GpF"
alias redraw="stty sane && clear"
alias tmux="tmux -2"
alias vi="vim"

if command -v mvim >/dev/null 2>&1; then
  alias vim="mvim -v"
fi

case "$(uname -s)" in
  Darwin)
    alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
    alias slime="subl"
    ;;
esac

# Automatically wrap Git with Hub
eval "$(hub alias -s)"
