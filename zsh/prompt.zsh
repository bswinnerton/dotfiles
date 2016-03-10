autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  branch=$($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
  if [ -z "$branch" ]; then
    echo ""
  else
    echo "|%{$fg[yellow]%}$branch%{$reset_color%}"
  fi
}

git_dirty() {
  if $(! $git status -s --ignore-submodules=dirty &> /dev/null); then
    echo "%{$fg[red]%}♥%{$reset_color%}"
  else
    if [[ $($git status --porcelain --ignore-submodules=dirty) == "" ]]; then
      echo "%{$fg[red]%}♥%{$reset_color%}"
    else
      echo "%{$fg[red]%}♨%{$reset_color%}"
    fi
  fi
}

need_push_or_push() {
  local=$(git rev-parse @ 2>/dev/null)
  remote=$(git rev-parse @{u} 2>/dev/null)
  base=$(git merge-base @ @{u} 2>/dev/null)

  if [ $local = $remote 2>/dev/null ]; then
    # Up to date
    echo ""
  elif [ $local = $base 2>/dev/null ]; then
    # Need pull
    echo "%{$fg_bold[magenta]%} ⬇%{$reset_color%}"
  elif [ $remote = $base 2>/dev/null ]; then
    # Need push
    echo "%{$fg_bold[magenta]%} ⬆%{$reset_color%}"
  else
    # Diverged
    echo "%{$fg_bold[magenta]%} ➡%{$reset_color%}"
  fi
}

directory_name() {
  echo "%{$fg[blue]%}%0~%{$reset_color%}"
}

username() {
  echo "%{$fg[green]%}%n"
}

host() {
  echo "%m%{$reset_color%}"
}

PROMPT='$(username)@$(host):$(directory_name)$(git_branch)$(git_dirty)$(need_push_or_push) '
