# Create a new git worktree in <repo>/.worktrees/<branch>/
# Usage:
#   gwta my-feature   → creates new branch "my-feature" off origin/main + worktree, cd into it
#   gwta              → fetches origin, shows remote branches in fzf, creates worktree for selection
function gwta --description "Add a git worktree"
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null; or git rev-parse --git-common-dir 2>/dev/null | xargs dirname)
    set -l wt_base "$repo_root/.worktrees"

    if test (count $argv) -gt 0
        # New branch off origin/main
        set -l branch $argv[1]
        set -l wt_path "$wt_base/$branch"
        git worktree add -b "$branch" "$wt_path" origin/main
        and cd "$wt_path"
    else
        # Pick from remote branches via fzf
        git fetch origin
        set -l branch (git branch -r --format='%(refname:short)' | sed 's|^origin/||' | \
            grep -v HEAD | sort -u | \
            fzf --height=40% --reverse --info=inline --prompt="Branch> ")
        if test -n "$branch"
            set -l wt_path "$wt_base/$branch"
            git worktree add "$wt_path" "origin/$branch"
            and cd "$wt_path"
        end
    end
end
