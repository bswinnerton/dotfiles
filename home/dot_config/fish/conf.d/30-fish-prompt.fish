if not status is-interactive
  return
end

# Via https://git.io/vS5Tk

set -g __fish_git_prompt_show_informative_status 'yes'

set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showuntrackedfiles 'no'
set -g __fish_git_prompt_showupstream 'yes'
set -g __fish_git_prompt_color_dirtystate red
set -g __fish_git_prompt_color_stagedstate red
set -g __fish_git_prompt_color_untrackedfiles red
set -g __fish_git_prompt_color_upstream red
set -g __fish_git_prompt_color_cleanstate red
set -g __fish_git_prompt_color_invalidstate red

set -g __fish_git_prompt_char_cleanstate '✔'
set -g __fish_git_prompt_char_dirtystate '𝚫'
set -g __fish_git_prompt_char_invalidstate 'x'
set -g __fish_git_prompt_char_stagedstate '●'
set -g __fish_git_prompt_char_untrackedfiles '+'
set -g __fish_git_prompt_char_upstream_behind '⬇ '
set -g __fish_git_prompt_char_upstream_ahead '⬆ '
set -g __fish_git_prompt_char_stateseparator ' '

set fish_greeting

function fish_prompt
  set_color green
  printf '%s' (whoami)@(hostname -s)

  set_color normal
  printf ':'

  set_color blue
  printf '%s' (prompt_pwd)

  if git -C . rev-parse 2>/dev/null
    set_color normal
    printf '|'
    set_color yellow

    # Opt out for any large repository (including subdirectories and worktrees).
    # Avoid index/working-tree scans when the Git index itself is large.
    set -l index_path (git rev-parse --git-path index 2>/dev/null)
    set -l index_kb 0
    if test -f "$index_path"
      set index_kb (command du -k "$index_path" 2>/dev/null | string match -r '^[0-9]+')
    end
    set -l prompt_dirty (git config --bool dotfiles.promptDirty 2>/dev/null)
    if test "$prompt_dirty" = false; or test "$index_kb" -ge 10240
      printf '%s' (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    else
      printf '%s' (__fish_git_prompt '%s')
    end
  end

  set_color normal
  printf '\n'

  set_color cyan
  printf '$ '

  set_color normal
end
