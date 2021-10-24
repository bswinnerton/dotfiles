set -g fish_user_paths $HOME/.nodenv/bin $fish_user_paths
status --is-interactive; and source (nodenv init -|psub)
