if type -q brew
  set -l prefix (brew --prefix)
  fish_add_path $prefix/sbin
  if test -d $prefix/opt/curl/bin
    fish_add_path $prefix/opt/curl/bin
  end
end
fish_add_path $HOME/bin $HOME/.local/bin
