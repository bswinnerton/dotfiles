alias b="bundle"
alias be="bundle exec"
alias gist="gist -p"
alias git="/usr/local/bin/git"
alias gti="git"
alias ls="ls -GpF"
alias redraw="stty sane && clear"
alias tmux="tmux -2"
alias vi="vim"
alias vim="nvim"
alias webhook-proxy="ngrok http 4567 --hostname bswinnerton.ngrok.io"

case "$(uname -s)" in
  Darwin)
    alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
    alias slime="subl"
    ;;
esac
