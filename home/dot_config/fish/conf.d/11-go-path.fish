if not status is-interactive
  return
end

set -g -x GOPATH $HOME/go
set -g -x fish_user_paths $GOPATH/bin $fish_user_paths
