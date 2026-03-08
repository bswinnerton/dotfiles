function worktree -d "Manage git worktrees"
    if test (count $argv) -eq 0
        echo "Usage: worktree <command> [branch]"
        echo ""
        echo "Commands:"
        echo "  worktree <branch>         CD into an existing worktree"
        echo "  worktree create <branch>  Create a new worktree in .claude/worktrees/"
        echo "  worktree base             CD into the main worktree"
        echo "  worktree rm <name>        Remove a worktree"
        echo "  worktree list             List all worktrees"
        return 0
    end

    if test "$argv[1]" = list
        git worktree list --porcelain 2>/dev/null | string match 'worktree *' | string replace -r '.*/' '' | tail -n +2
        return $status
    end

    if test "$argv[1]" = base
        set -l base_path (git worktree list --porcelain 2>/dev/null | head -1 | string replace "worktree " "")
        if test -n "$base_path"
            cd "$base_path"
        else
            echo "Not in a git repository"
            return 1
        end
        return 0
    end

    if test "$argv[1]" = rm
        if test (count $argv) -lt 2
            echo "Usage: worktree rm <name>"
            return 1
        end
        set -l name $argv[2]
        set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
        if test $status -ne 0
            echo "Not in a git repository"
            return 1
        end

        # Find the worktree path by directory name
        set -l wt_dir "$git_root/.claude/worktrees/$name"
        if not test -d "$wt_dir"
            # Check ../<something>-<name> pattern
            set -l parent (dirname $git_root)
            for dir in $parent/*-$name
                if test -d "$dir"; and test -d "$dir/.git" -o -f "$dir/.git"
                    set wt_dir "$dir"
                    break
                end
            end
        end

        if not test -d "$wt_dir"
            echo "Worktree '$name' not found"
            return 1
        end

        # If we're inside the worktree, cd to base first
        if string match -q "$wt_dir*" (pwd)
            set -l base_path (git worktree list --porcelain 2>/dev/null | head -1 | string replace "worktree " "")
            cd "$base_path"
        end

        git worktree remove "$wt_dir"
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

        set -l dir_name (string replace -a '/' '-' $branch)
        set -l wt_dir "$git_root/.claude/worktrees/$dir_name"
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
            git push -u origin "$branch" 2>/dev/null
            or git branch --set-upstream-to=origin/"$branch" "$branch" 2>/dev/null
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

    # Fall back to matching by git branch name
    set -l porcelain (git worktree list --porcelain 2>/dev/null)
    set -l wt_path
    for i in (seq (count $porcelain))
        if test "$porcelain[$i]" = "branch refs/heads/$branch"
            # Walk back to find the worktree line
            for j in (seq (math $i - 1) -1 1)
                if string match -q "worktree *" $porcelain[$j]
                    set wt_path (string replace "worktree " "" $porcelain[$j])
                    break
                end
            end
            break
        end
    end
    if test -n "$wt_path"
        cd "$wt_path"
        return 0
    end

    echo "Worktree for branch '$branch' not found"
    return 1
end
