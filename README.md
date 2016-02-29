# Brooks' Dotfiles

Dotfiles are the preferences, tricks and hacks that you use to tame your
terminal. These are mine.

![dotfiles](https://cloud.githubusercontent.com/assets/934497/13386200/6a258952-de6f-11e5-96cd-7708a3174cfe.png)


The structure of these dotfiles are heavily influenced by
[holman's](https://github.com/holman/dotfiles), but the contents have been
created and curated by myself over the years.

## Installation

```
git clone https://github.com/bswinnerton/dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap
./install
```

## Components

There's a few special files in the hierarchy.

- `bin/`: Anything in bin/ will get added to your $PATH and be made available
  everywhere.
- `topic/*.zsh`: Any files ending in .zsh get loaded into your environment.
- `topic/path.zsh`: Any file named path.zsh is loaded first and is expected to
  setup $PATH or similar.
- `topic/completion.zsh`: Any file named completion.zsh is loaded last and is
  expected to setup autocomplete.
- `topic/*.symlink`: Any files ending in `*.symlink` get symlinked into your
  $HOME.  This is so you can keep all of those versioned in your dotfiles but
  still keep those autoloaded files in your home directory. These get symlinked
  in when you run script/bootstrap.
- `topic/install.sh`: Any file named install.sh is automatically loaded when you
  call `script/install`.

## Thanks

- [@holman](https://github.com/holman/dotfiles)
- [@ryanb](https://github.com/ryanb/dotfiles)
