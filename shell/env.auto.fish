set -gx BAT_THEME base16
set -gx GPG_TTY (tty)

if command -v zed > /dev/null
    set -gx EDITOR zed
else
    set -gx EDITOR vim
end
