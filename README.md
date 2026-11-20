# Brooks' Dotfiles

Dotfiles are the preferences, tricks and hacks that you use to tame your
terminal. There are many like them, but these are mine.

![dotfiles](https://user-images.githubusercontent.com/934497/27137962-48dfe62e-50ed-11e7-990a-587e9a66851c.png)

These are my personal [chezmoi](https://www.chezmoi.io/) base, with fish as the
interactive shell on macOS and Linux. They grew out of
[@holman's](https://github.com/holman/dotfiles) layout.

## Installation

Install chezmoi, then:

```sh
chezmoi init --apply bswinnerton/dotfiles
```

To review an existing installation before applying:

```sh
chezmoi init bswinnerton/dotfiles
chezmoi diff
chezmoi apply
```

Until the conversion merges, select the branch with
`chezmoi init --apply --branch chezmoi bswinnerton/dotfiles`.

On macOS, the first apply installs Homebrew (if needed), runs the Brewfile,
and applies the existing macOS and Zed preferences. Homebrew bootstrap uses
`NONINTERACTIVE=1`; prepare its required permissions first if it is not already
installed. No installer prompts for a password or changes your login shell.
On Linux, install fish with your package manager, then select it as your
terminal's interactive shell. On a Stripe devbox, use go/dev's default terminal
shell setting (`/usr/bin/fish`).

An apply replaces the old installer's symlinks with managed files/directories;
it does not modify their old source checkout. Review the diff and preserve any
uncommitted personal changes before migrating. `~/.bundle/config` is no longer
managed: remove the old EventMachine OpenSSL override there if migrating from
the old installer. Old binaries in `~/.dotfiles/bin` are no longer put on PATH.
Ngrok comes from the macOS Brewfile rather than a committed executable.

## Source and target layout

`.chezmoiroot` selects `home/`. README, examples, and tests stay in the repo.
The old `topic/*.symlink` files are now `home/dot_*` entries, applied as real
files in `$HOME`. `~/.config/nvim` points relatively to `~/.vim`, whose
`init.vim` points relatively to `~/.vimrc`.

Fish loads `~/.config/fish/conf.d/*.fish` automatically. Numeric prefixes keep
theme/key bindings first, PATH setup before environment/prompt settings, and
local executable paths last. Put private settings in `conf.d/zz-local.fish`;
`examples/private-env.fish.example` shows the previous private-settings pattern.
The base does not export `~/.env` by default. To retain that behavior explicitly,
run `set -U dotfiles_load_env 1` in fish; disable it with
`set -U dotfiles_load_env 0`. Use directory-scoped environment tooling for
project credentials instead of opting in globally.

The prompt skips expensive Git dirty-state checks when the index occupies at
least 10 MiB. You can disable them for any repository (and all its subdirectories
and worktrees) with `git config dotfiles.promptDirty false`, or globally with
`git config --global dotfiles.promptDirty false`. Ordinary repositories retain
the informative prompt.

macOS-only files are ignored on Linux: Hammerspoon, Ghostty, the Brewfile,
Tampermonkey, LaunchBar, backgrounds, and tools using macOS services. LaunchBar
files live in `~/Library/Application Support/LaunchBar`, backgrounds in
`~/Pictures/backgrounds`, and the userscript in `~/.config/tampermonkey` (import
it into the browser manually).

`run_onchange_` scripts replace setup scripts; they are OS-gated and safe to
reapply without prompts. Config changes to the Brewfile or terminfo definitions
also trigger their installers. Git submodules have been replaced by HTTPS
clones: TPM and tmux-resurrect in `~/.tmux/plugins`, fonts in
`~/.local/share/dotfiles-fonts` (copied into `~/Library/Fonts`), and the GitHub
LaunchBar action under LaunchBar's Actions directory. The three former
submodules retain their original pinned revisions. Existing clones are kept.

## Work overlay interface

A separate work source applies after this base. It owns the exclusion list and
writes the following data in `~/.config/chezmoi/chezmoi.toml` **before** applying
the base:

```toml
[data]
is_work = true
work_exclude = [
  ".config/fish/functions/worktree.fish",
  ".config/fish/completions/worktree.fish",
  ".config/fish/conf.d/38-shell-secrets.fish",
  ".config/fish/conf.d/39-shell-stripe.fish",
  "70-rust.sh",
  "71-go.sh",
  "72-agents.sh",
]
```

`is_work` is a boolean, defaulting to `false` if absent. It gates the legacy
Stripe login snippet. `work_exclude` is a list of target paths relative to
`$HOME`, defaulting to an empty list if absent. The template
`home/.chezmoiignore` loops over every entry in addition to OS exclusions; the
base contains no hardcoded work exclusion list. Chezmoi ignore patterns can
also exclude a directory. Excluding a target stops the base managing it; it
does not delete an already-installed copy. The overlay should reconcile any
old copies once and should not repeatedly delete base-managed files.

The base `~/.gitconfig` ends with:

```gitconfig
[include]
  path = ~/.config/git/config.local
```

The overlay supplies that file for work identity and overrides. A missing
include file on a personal machine is fine. Keep machine-specific identity and
signing settings there (or in another included file) rather than editing the
base Git config.

These are final target names, not source filenames:

| Component | Excludable target paths relative to `$HOME` |
| --- | --- |
| Fish functions/completion | `.config/fish/functions/worktree.fish`, `.config/fish/completions/worktree.fish`, `.config/fish/functions/ssh.fish`, `.config/fish/functions/setenv.fish`, `.config/fish/functions/fzf_key_bindings.fish` |
| Fish theme/key bindings | `.config/fish/conf.d/01-fish_frozen_key_bindings.fish`, `.config/fish/conf.d/02-fish_frozen_theme.fish` |
| Fish paths | `.config/fish/conf.d/09-homebrew-path.fish`, `.config/fish/conf.d/10-fzf-path.fish`, `.config/fish/conf.d/11-go-path.fish`, `.config/fish/conf.d/13-shell-path.fish`, `.config/fish/conf.d/90-local-path.fish` |
| Fish environment/prompt | `.config/fish/conf.d/30-fish-prompt.fish`, `.config/fish/conf.d/31-fzf-fzf.fish`, `.config/fish/conf.d/32-node-node.fish`, `.config/fish/conf.d/33-python-pyenv.fish`, `.config/fish/conf.d/34-ruby-rbenv.fish`, `.config/fish/conf.d/35-rust-cargo.fish`, `.config/fish/conf.d/36-shell-aliases.fish`, `.config/fish/conf.d/37-shell-env.fish`, `.config/fish/conf.d/38-shell-secrets.fish`, `.config/fish/conf.d/39-shell-stripe.fish` |
| Portable tools | `bin/asn`, `bin/curl-headers`, `bin/extract`, `bin/gcurl`, `bin/headers`, `bin/macgen`, `bin/print-colors`, `bin/uuidgen`, `bin/webhook-server`, `bin/webserver`, `bin/with_date` |
| macOS tools | `bin/copy-as-rtf`, `bin/drac-proxy`, `bin/gitio`, `bin/lock-screen`, `bin/mosh`, `bin/spoof-mac`, `bin/vnc-to-virsh` |
| Common installers | `50-shell.sh`, `60-tmux.sh`, `70-rust.sh`, `71-go.sh`, `72-agents.sh` |
| macOS installers | `10-homebrew.sh`, `20-brew-bundle.sh`, `30-git.sh`, `40-osx.sh`, `41-zed.sh`, `61-fonts.sh`, `62-launchbar.sh` |
| macOS configuration | `.hammerspoon`, `.config/ghostty`, `.config/homebrew`, `.config/tampermonkey`, `Library/Application Support/LaunchBar`, `Pictures/backgrounds` |

The installer names above are how `chezmoi managed` identifies scripts for
ignore rules; scripts run during apply and do not leave those files in `$HOME`.
`bin/ngrok` and `bin/zeus` have been removed; retaining those names in an overlay
exclusion list is harmless. For all other targets, `chezmoi managed` gives the
complete current list. To preview just file changes without executing any
installer, use `chezmoi apply --dry-run`; to apply only files, use
`chezmoi apply --exclude=scripts`.

## Tests

```sh
python3 tests/check.py
```

Requires chezmoi and Python 3; install fish to include runtime checks. Tests
isolate HOME, XDG directories, destination, config, cache, and persistent state.
They check Linux personal and work target lists, dry runs, default data,
exclusions, the Git include, migration from old symlinks, repeated file applies,
relative Neovim links, fish startup, dotenv opt-in, and prompt behavior. Darwin
personal/work coverage renders templates and checks installer shell syntax;
it does not execute Homebrew, downloads, agent installers, or macOS defaults.
An actual macOS apply and app smoke check still need laptop validation.

## Thanks

- [@holman](https://github.com/holman/dotfiles)
- [@ryanb](https://github.com/ryanb/dotfiles)
