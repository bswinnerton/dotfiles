if not status is-interactive
  return
end

# Explicitly opt in with: set -U dotfiles_load_env 1
if set -q dotfiles_load_env; and test "$dotfiles_load_env" = 1; and test -f ~/.env
    for line in (grep -v '^#' ~/.env | grep -v '^\s*$')
        set -l key (string split -m1 '=' -- $line)[1]
        set -l val (string split -m1 '=' -- $line)[2]
        set -gx $key $val
    end
end
