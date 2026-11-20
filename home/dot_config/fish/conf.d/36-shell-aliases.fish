if not status is-interactive
  return
end

alias be "bundle exec"
alias gist "gist -p"
alias gti "git"
alias history "less ~/.local/share/fish/fish_history"
if test (uname) = Darwin
  alias ls "ls -GpF"
else
  alias ls "ls --color=auto -pF"
end
alias mux "tmuxinator"
alias obj "~/stripe/lamflam/scripts/objects/obj"
alias redraw "stty sane; clear"
function reload
  redraw
  for file in ~/.config/fish/conf.d/*.fish
    source $file
  end
  source ~/.config/fish/config.fish
end
alias speedtest "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias tmux "tmux -2"
alias vim "nvim"
alias webhook-proxy "ngrok http 4567 --hostname bswinnerton.ngrok.io"
