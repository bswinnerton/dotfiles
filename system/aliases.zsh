alias b="bundle"
alias be="bundle exec"
alias ls="ls -GpF"
alias vi="vim"
alias tmux="tmux -2"

case "$(uname -s)" in
  Darwin)
    alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
    alias slime="subl"
    ;;
esac

# Automatically wrap Git with Hub
eval "$(hub alias -s)"
