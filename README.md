# Brooks' Dotfiles

Dotfiles are the preferences, tricks and hacks that you use to tame your
terminal. There are many like them, but these are mine.

![dotfiles](https://cloud.githubusercontent.com/assets/934497/24736577/c3d3684c-1a56-11e7-845d-034de947a4d4.png)


The structure of these dotfiles are heavily influenced by
[@holman's](https://github.com/holman/dotfiles), but the contents have been
created and curated by myself over the years.

## Installation

```
git clone https://github.com/bswinnerton/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install
```

## Components

There are a few special files and conventions to point out:

- `bin/`: Anything in bin/ will be added to your `$PATH` and be made available
  to execute anywhere in your shell.
- `topic/path.fish`: Any file named path.fish is loaded first and is expected to
  setup `$PATH` or similar.
- `topic/*.auto.fish`: Any files ending in .auto.fish get loaded into your
  environment.
- `topic/*.auto.sh`: Any files ending in .auto.sh get loaded into your
  environment, after any `.auto.fish` files.
- `topic/*.symlink`: Any files ending in `*.symlink` get symlinked into your
  $HOME. This is so you can keep all of those versioned in your dotfiles but
  still keep those autoloaded files in your home directory. These get symlinked
  in when you run ./install.
- `topic/install.sh`: Any file named `install.sh` is automatically loaded when
  you call `./install`.

## Thanks

- [@holman](https://github.com/holman/dotfiles)
- [@ryanb](https://github.com/ryanb/dotfiles)
