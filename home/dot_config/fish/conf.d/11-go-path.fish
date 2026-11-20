if not status is-interactive
  return
end

set -g -x GOPATH $HOME/go
fish_add_path --move $GOPATH/bin
