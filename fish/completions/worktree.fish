function __worktree_directories
    # Skip the first (base) worktree
    git worktree list --porcelain 2>/dev/null | string match 'worktree *' | string replace -r '.*/' '' | tail -n +2
end

function __worktree_branches
    git branch -a --format='%(refname:short)' 2>/dev/null
end

# Disable file completions
complete -c worktree -f

# Subcommands
complete -c worktree -n "test (count (commandline -opc)) -eq 1" -a base -d "Command"
complete -c worktree -n "test (count (commandline -opc)) -eq 1" -a create -d "Command"
complete -c worktree -n "test (count (commandline -opc)) -eq 1" -a list -d "Command"

# Complete existing worktree directory names
complete -c worktree -n "test (count (commandline -opc)) -eq 1" -a "(__worktree_directories)" -d "Worktree"

# Complete branch names for `worktree create <branch>`
complete -c worktree -n "test (count (commandline -opc)) -eq 2; and test (commandline -opc)[2] = create" -a "(__worktree_branches)" -d "Branch"
