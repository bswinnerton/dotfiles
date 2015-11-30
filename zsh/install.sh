current_user=$(whoami)
zsh_path=$(which zsh)

[ ! $(grep -q "zsh" "/etc/shells") ] || $zsh_path | sudo tee -a /etc/shells

sudo chsh -s $zsh_path $current_user

unset current_user zsh_path
