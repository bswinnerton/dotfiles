if test (uname -m) = arm64
  set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
else
  set -U fish_user_paths /usr/local/homebrew/bin $fish_user_paths
end
