if type -q brew
  set -g fish_user_paths /opt/homebrew/sbin $fish_user_paths

  if test -d (brew --prefix)/opt/curl/bin
    set -g fish_user_paths (brew --prefix)/opt/curl/bin $fish_user_paths
  end
end

# Ensure ~/.dotfiles/bin is always first in PATH
set -g fish_user_paths ~/.dotfiles/bin $fish_user_paths
