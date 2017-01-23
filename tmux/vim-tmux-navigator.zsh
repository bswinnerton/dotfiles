# Patch to enable <C-h> support in Neovim: https://git.io/vMde7
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti
