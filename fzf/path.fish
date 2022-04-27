if test -d (brew --prefix)/opt/fzf/bin
  set -g fish_user_paths (brew --prefix)/opt/fzf/bin $fish_user_paths
end
