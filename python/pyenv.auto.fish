if type -q pyenv
  status --is-interactive; and source (pyenv init -|psub)
end
