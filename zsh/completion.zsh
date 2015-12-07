# Matches case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Allows for pasted commands to use autocomplete
zstyle ':completion:*' insert-tab pending

# Sets autocomplete colors to use LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Highlight the background of autocompleted values
zstyle ':completion:*' menu select
