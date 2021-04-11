# A workaround for Fish re-reading config for non-interactive execution:
# https://git.io/yj4KoA
if not status --is-interactive
  exit
end

# Autoload any files that update the $PATH first
for file in (rg --files ~/.dotfiles/ | rg path.fish)
  source $file
end

# Autoload any files that end in .auto.fish
for file in (rg --files ~/.dotfiles/ | rg ".*\.auto.fish\z")
  source $file
end

# Autoload any files that end in auto.sh
for file in (rg --files ~/.dotfiles/ | rg ".*\.auto.sh\z")
  sh $file
end
