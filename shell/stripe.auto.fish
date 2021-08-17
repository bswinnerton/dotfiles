if status --is-login; and status --is-interactive; and test -e $HOME/.stripeproxy
    # Add the stripe tools paths
    set PATH $HOME/stripe/space-commander/bin $PATH
    set PATH $HOME/stripe/password-vault/bin $PATH
    set PATH $HOME/stripe/henson/bin $PATH

    # Activate the space-commander env
    source $HOME/stripe/space-commander/bin/sc-env-activate.fish
    functions -e fish_right_prompt
end
