if not status is-interactive
  return
end

if type -q brew
  if test -d (brew --prefix)/opt/fzf/bin
    fish_add_path --move (brew --prefix)/opt/fzf/bin
  end
end
