if test (uname -m) = arm64
  set -g fish_user_paths /opt/homebrew/bin $fish_user_paths
else
  set -g fish_user_paths /usr/local/homebrew/bin $fish_user_paths
end
