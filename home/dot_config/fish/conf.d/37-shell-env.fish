if not status is-interactive
  return
end

set -gx BAT_THEME base16
set -gx GPG_TTY (tty)

if test (uname) = Darwin; and type -q zed
    set -gx EDITOR zed
else
    set -gx EDITOR vim
end
