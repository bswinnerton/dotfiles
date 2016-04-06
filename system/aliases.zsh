alias b="bundle"
alias be="bundle exec"
alias ls="ls -GpF"
alias redraw="stty sane && clear"
alias tmux="tmux -2"
alias vi="vim"

case "$(uname -s)" in
  Darwin)
    alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
    alias slime="subl"
    ;;
esac

# Automatically wrap Git with Hub
eval "$(hub alias -s)"
