# Disable file completions
complete -c worktree -f

# Subcommands
complete -c worktree -n "test (count (commandline -opc)) -eq 1" -a list -d "List all worktrees"
complete -c worktree -n "test (count (commandline -opc)) -eq 1" -a create -d "Create a new worktree"

# Complete existing worktree branches for bare `worktree <branch>`
complete -c worktree -n "test (count (commandline -opc)) -eq 1" -a "(git worktree list --porcelain 2>/dev/null | string match 'branch *' | string replace 'branch refs/heads/' '')" -d "Worktree"

# Complete branch names for `worktree create <branch>`
complete -c worktree -n "test (count (commandline -opc)) -eq 2; and test (commandline -opc)[2] = create" -a "(git branch -a --format='%(refname:short)' 2>/dev/null)" -d "Branch"
