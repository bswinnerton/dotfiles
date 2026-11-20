if not status is-interactive
  return
end

if type -q pyenv
  pyenv init - fish | source
end
