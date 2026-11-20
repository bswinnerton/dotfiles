if test -d $HOME/.local/share/fnm
  fish_add_path $HOME/.local/share/fnm
end
if status is-interactive; and type -q fnm
  fnm env --shell fish | source
end
