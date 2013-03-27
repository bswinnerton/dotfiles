# Yay! High voltage and arrows!

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[yellow]%}|"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#PROMPT='%{$fg[magenta]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[yellow]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}⇒%{$reset_color%}  '

PROMPT='%{$fg[green]%}%n%{$reset_color%}%{$fg[green]%}@%{$reset_color%}%{$fg[green]%}%m%{$reset_color%}%{$fg[green]%}:%{$reset_color%}%{$fg[blue]%}%0~%{$reset_color%}$(git_prompt_info)%{$reset_color%}%{$fg[red]%}♥%{$reset_color%} '

export LS_COLORS="di=01;34:ln=01;35:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
