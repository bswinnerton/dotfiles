# A workaround for Fish re-reading config for non-interactive execution:
# https://git.io/yj4KoA
if not status --is-interactive
  exit
end

# Load any files that end in .fish first
for file in ~/.dotfiles/**/*.auto.fish
  source $file
end

# Autoload any files that end in auto.sh
for file in ~/.dotfiles/**/path.sh
  sh $file
end

# Autoload any files that end in auto.sh
for file in ~/.dotfiles/**/*.auto.sh
  sh $file
end

# Execute Archey
~/.dotfiles/bin/archey

# Resource FZF to ensure keybindings are set on top of ZSH
sh ~/.dotfiles/fzf/fzf.auto.sh
