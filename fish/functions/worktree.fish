function worktree -d "Manage git worktrees"
    if test (count $argv) -eq 0
        echo "Usage: worktree <command> [branch]"
        echo ""
        echo "Commands:"
        echo "  worktree <branch>         CD into an existing worktree"
        echo "  worktree create <branch>  Create a new worktree in .claude/worktrees/"
        echo "  worktree list             List all worktrees"
        return 0
    end

    if test "$argv[1]" = list
        git worktree list
        return $status
    end

    if test "$argv[1]" = create
        if test (count $argv) -lt 2
            echo "Usage: worktree create <branch>"
            return 1
        end
        set -l branch $argv[2]
        set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
        if test $status -ne 0
            echo "Not in a git repository"
            return 1
        end

        set -l wt_dir "$git_root/.claude/worktrees/$branch"
        if test -d "$wt_dir"
            echo "Worktree already exists at $wt_dir"
            cd "$wt_dir"
            return 0
        end

        mkdir -p "$git_root/.claude/worktrees"
        git worktree add "$wt_dir" -b "$branch" 2>/dev/null
        or git worktree add "$wt_dir" "$branch"
        if test $status -eq 0
            cd "$wt_dir"
        end
        return
    end

    set -l branch $argv[1]
    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
    if test $status -ne 0
        echo "Not in a git repository"
        return 1
    end

    # Check .claude/worktrees/<branch>
    set -l claude_path "$git_root/.claude/worktrees/$branch"
    if test -d "$claude_path"
        cd "$claude_path"
        return 0
    end

    # Check ../<something>-<branch> pattern
    set -l parent (dirname $git_root)
    for dir in $parent/*-$branch
        if test -d "$dir"; and test -d "$dir/.git" -o -f "$dir/.git"
            cd "$dir"
            return 0
        end
    end

    echo "Worktree for branch '$branch' not found"
    return 1
end
