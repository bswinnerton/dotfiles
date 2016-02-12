alias b="bundle"
alias be="bundle exec"
alias ls="ls -GpF"
alias vi="vim"

case "$(uname -s)" in
  Darwin)
    alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
    alias slime="subl"
    alias tmux="tmux -2 -f ~/.tmux.osx.conf"
    ;;

 Linux)
    alias tmux="tmux -2 -f ~/.tmux.linux.conf"
    ;;
esac

# Automatically wrap Git with Hub
eval "$(hub alias -s)"
