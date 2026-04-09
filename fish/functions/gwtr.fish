# Remove a git worktree interactively.
# Usage: gwtr
#   1. Lists all worktrees except the main one via fzf
#   2. Select one → git worktree remove it
function gwtr --description "Remove a git worktree (fzf)"
    set -l selected (git worktree list | tail -n +2 | \
        fzf --height=40% --reverse --info=inline --prompt="Remove> ")
    if test -n "$selected"
        set -l wt_path (echo "$selected" | awk '{print $1}')
        git worktree remove "$wt_path"
    end
end
