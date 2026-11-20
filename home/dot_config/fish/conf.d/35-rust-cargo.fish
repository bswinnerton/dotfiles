if not status is-interactive
  return
end

set -g fish_user_paths $HOME/.cargo/bin $fish_user_paths
