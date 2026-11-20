function fzf_key_bindings
  if type -q brew
    set -l bindings (brew --prefix)/opt/fzf/shell/key-bindings.fish
    if test -f $bindings
      source $bindings
      fzf_key_bindings $argv
    end
  else if test -f /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
    source /usr/share/fish/vendor_functions.d/fzf_key_bindings.fish
    fzf_key_bindings $argv
  end
end
