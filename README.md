# Brooks' Dotfiles

Dotfiles are the preferences, tricks and hacks that you use to tame your
terminal. There are many like them, but these are mine.

![dotfiles](https://cloud.githubusercontent.com/assets/934497/14234999/7cb3bf24-f9bf-11e5-835e-2a18175d5e44.png)


The structure of these dotfiles are heavily influenced by
[@holman's](https://github.com/holman/dotfiles), but the contents have been
created and curated by myself over the years.

## Installation

```
git clone https://github.com/bswinnerton/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install
./bootstrap
```

## Components

There are a few special files and conventions to point out:

- `bin/`: Anything in bin/ will be added to your `$PATH` and be made available
  to execute anywhere in your shell.
- `topic/*.zsh`: Any files ending in .zsh get loaded into your environment.
- `topic/path.zsh`: Any file named path.zsh is loaded first and is expected to
  setup `$PATH` or similar.
- `topic/completion.zsh`: Any file named `completion.zsh` is loaded last and is
  expected to setup autocomplete.
- `topic/*.symlink`: Any files ending in `*.symlink` get symlinked into your
  $HOME.  This is so you can keep all of those versioned in your dotfiles but
  still keep those autoloaded files in your home directory. These get symlinked
  in when you run script/bootstrap.
- `topic/install.sh`: Any file named `install.sh` is automatically loaded when
  you call `script/install`.

## Thanks

- [@holman](https://github.com/holman/dotfiles)
- [@ryanb](https://github.com/ryanb/dotfiles)
