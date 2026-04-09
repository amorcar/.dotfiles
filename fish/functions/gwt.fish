# Switch between existing git worktrees interactively.
# Usage: gwt
#   1. Lists all worktrees via fzf
#   2. Select one → cd into it
function gwt --description "Fuzzy switch between git worktrees"
    set -l selected (git worktree list | fzf --height=40% --reverse --info=inline | awk '{print $1}')
    if test -n "$selected"
        cd "$selected"
    end
end
