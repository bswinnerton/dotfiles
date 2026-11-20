#!/usr/bin/env python3
"""Exercise the real chezmoi CLI with isolated homes; never run installers."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

SOURCE = Path(__file__).resolve().parents[1]
CHEZMOI = shutil.which('chezmoi') or str(Path.home() / '.local/bin/chezmoi')
FISH = shutil.which('fish')
MAC_TARGETS = [
    '.hammerspoon', '.config/ghostty', '.config/homebrew',
    '.config/tampermonkey', 'Library', 'Pictures',
    'bin/drac-proxy', 'bin/spoof-mac', 'bin/mosh', 'bin/lock-screen',
    '10-homebrew.sh', '20-brew-bundle.sh', '40-osx.sh', '41-zed.sh',
    '61-fonts.sh', '62-launchbar.sh',
]
EXCLUDED = [
    'bin/ngrok', 'bin/macgen', '.config/fish/functions/worktree.fish',
    '.config/fish/conf.d/38-shell-secrets.fish',
    '70-rust.sh', '71-go.sh', '72-agents.sh',
]


def check_mode(root, work):
    home = root / ('work' if work else 'personal')
    home.mkdir()
    config = home / 'chezmoi.toml'
    config.write_text('[data]\nis_work = true\nwork_exclude = ' + json.dumps(EXCLUDED) + '\n' if work else '')
    env = dict(os.environ, HOME=str(home), XDG_CONFIG_HOME=str(home / '.config'),
               XDG_DATA_HOME=str(home / '.local/share'), XDG_CACHE_HOME=str(home / '.cache'),
               XDG_STATE_HOME=str(home / '.local/state'), TERM='xterm')
    cli = [CHEZMOI, '--source', str(SOURCE), '--destination', str(home),
           '--config', str(config), '--persistent-state', str(home / 'state.boltdb'),
           '--cache', str(home / '.cache/chezmoi'), '--no-tty', '--force']

    def cm(*args, data=None):
        cmd = cli + (['--override-data', json.dumps(data)] if data else []) + list(args)
        return subprocess.check_output(cmd, env=env, text=True)

    linux = {'chezmoi': {'os': 'linux'}}
    managed = set(cm('managed', data=linux).splitlines())
    assert '.gitconfig' in managed
    assert '.config/fish/config.fish' in managed
    assert '.vim/init.vim' in managed and '.config/nvim' in managed
    assert not any(t in managed for t in MAC_TARGETS)
    assert 'bin/ngrok' not in managed and 'bin/zeus' not in managed
    assert 'README.md' not in managed and 'tests' not in managed
    for target in EXCLUDED[1:]:
        assert (target in managed) == (not work), target
    cm('apply', '--dry-run', data=linux)
    assert cm('execute-template', '{{ get . "is_work" | default false }}') == str(work).lower()
    gitconfig = cm('cat', str(home / '.gitconfig'), data=linux)
    assert gitconfig.endswith('[include]\n  path = ~/.config/git/config.local\n')
    assert 'editor = nvim' in gitconfig
    assert 'root: ' + json.dumps(str(SOURCE)) in cm('cat', str(home / '.tmuxinator/personal.yml'), data=linux)

    # Darwin is template-only: no brew, defaults, clones, or downloads execute.
    darwin = {'chezmoi': {'os': 'darwin'}}
    mac_managed = set(cm('managed', data=darwin).splitlines())
    assert all(t in mac_managed for t in MAC_TARGETS)
    cm('apply', '--dry-run', data=darwin)
    for script in SOURCE.glob('home/run_onchange_*.tmpl'):
        rendered = cm('execute-template', '--file', str(script), data=darwin)
        subprocess.run(['sh', '-n'], input=rendered, text=True, check=True)
        rendered = cm('execute-template', '--file', str(script), data=linux)
        subprocess.run(['sh', '-n'], input=rendered, text=True, check=True)
    # Exercise migration from installer-created directory/file symlinks as well.
    if not work:
        legacy = root / 'legacy'
        (legacy / 'fish').mkdir(parents=True)
        (legacy / 'vim').mkdir()
        (legacy / 'fish/config.fish').write_text('old fish config\n')
        (legacy / 'gitconfig').write_text('old git config\n')
        (home / '.config').mkdir(exist_ok=True)
        (home / '.config/fish').symlink_to(legacy / 'fish')
        (home / '.vim').symlink_to(legacy / 'vim')
        (home / '.gitconfig').symlink_to(legacy / 'gitconfig')
    # Apply only files to a disposable home, verify stable state on repeat apply.
    cm('apply', '--exclude=scripts', data=linux)
    assert (home / '.vim/init.vim').resolve() == home / '.vimrc'
    assert (home / '.config/nvim').resolve() == home / '.vim'
    if not work:
        assert not (home / '.config/fish').is_symlink()
        assert (legacy / 'fish/config.fish').read_text() == 'old fish config\n'
        assert (legacy / 'gitconfig').read_text() == 'old git config\n'
    assert os.access(home / 'bin/asn', os.X_OK)
    assert (home / 'bin/macgen').exists() == (not work)
    cm('apply', '--exclude=scripts', data=linux)
    cm('verify', '--exclude=scripts', data=linux)

    if FISH:
        for path in (home / '.config/fish').rglob('*.fish'):
            subprocess.run([FISH, '--no-config', '-n', str(path)], check=True, env=env)
        # Startup must keep synthetic dotenv data private and PATH free of ./bin.
        (home / '.env').write_text('DOTFILES_TEST_SECRET=synthetic\n')
        startup = '''
            if set -q DOTFILES_TEST_SECRET; exit 1; end
            if contains -- ./bin $PATH; exit 2; end
            type -q fish_prompt; or exit 3
            set -l before (string join : -- $fish_user_paths)
            for file in ~/.config/fish/conf.d/*.fish
                source $file
            end
            # Optional tools (e.g. distro rbenv) manage their own PATH state.
            # Re-sourcing base snippets must keep our managed path list stable.
            test (string join : -- $fish_user_paths) = "$before"; or exit 4
        '''
        result = subprocess.run([FISH, '-i', '-c', startup], env=env, text=True,
                                stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        assert result.returncode == 0, result.stderr
        assert 'test:' not in result.stderr and 'Unknown command' not in result.stderr, result.stderr
        if not work:
            secret = home / '.config/fish/conf.d/38-shell-secrets.fish'
            subprocess.run([FISH, '-i', '-c',
                            f'set -g dotfiles_load_env 1; source "{secret}"; '
                            'test "$DOTFILES_TEST_SECRET" = synthetic'], check=True, env=env,
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        # Prove both guards bypass the expensive fish helper, while ordinary repos use it.
        repo = home / 'prompt-repo'
        subprocess.run(['git', 'init', '-q', str(repo)], check=True, env=env)
        prompt = home / '.config/fish/conf.d/30-fish-prompt.fish'
        marker = home / 'dirty-helper-called'
        test_prompt = f'''
            source "{prompt}"
            function __fish_git_prompt
                touch "{marker}"
                printf dirty
            end
            fish_prompt >/dev/null
        '''
        def prompt_run():
            result = subprocess.run([FISH, '-i', '-c', test_prompt], check=True, env=env, cwd=repo,
                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            assert 'test:' not in result.stderr and 'Unknown command' not in result.stderr, result.stderr
        subprocess.run(['git', '-C', str(repo), 'config', 'dotfiles.promptDirty', 'false'], check=True, env=env)
        prompt_run()
        assert not marker.exists(), 'opt-out must bypass dirty helper'
        subprocess.run(['git', '-C', str(repo), 'config', '--unset', 'dotfiles.promptDirty'], check=True, env=env)
        # du reports allocated blocks; write a real large index-shaped file for the heuristic.
        (repo / '.git/index').write_bytes(b'0' * (11 * 1024 * 1024))
        prompt_run()
        assert not marker.exists(), 'large index must bypass dirty helper'
        (repo / '.git/index').unlink()
        prompt_run()
        assert marker.exists(), 'ordinary repo should keep informative prompt'
    print(('linux work' if work else 'linux personal') + ': managed, dry-run, templates, file apply, repeat apply, fish checks passed')


with tempfile.TemporaryDirectory(prefix='dotfiles-test-') as tmp:
    root = Path(tmp)
    check_mode(root, False)
    check_mode(root, True)
print('darwin personal/work templates and installer shell syntax passed')
if not FISH:
    print('fish unavailable: runtime checks skipped (install fish to include them)')
