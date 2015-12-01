alias be="bundle exec"
alias ls="ls -GpF"
alias vim="nvim"
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
