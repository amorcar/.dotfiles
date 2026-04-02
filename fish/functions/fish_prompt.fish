function fish_prompt
    # Fast worktree check (reusing our optimized method)
    set -l in_worktree false
    if command git --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_dir (command git --no-optional-locks rev-parse --git-dir 2>/dev/null)
        set -l common_dir (command git --no-optional-locks rev-parse --git-common-dir 2>/dev/null)
        if test "$git_dir" != "$common_dir"
            set in_worktree true
        end
    end

    set_color brgreen

    # Directory logic
    if test "$in_worktree" = "true"
        # Print parent/current (e.g., repo_name/branch_name)
        set -l parent_dir (basename (dirname $PWD))
        set -l current_dir (basename $PWD)
        echo -n "$parent_dir/$current_dir"
        
    else if test "$PWD" = "$HOME"
        # Print ~ if exactly in the home directory
        echo -n "~"
        
    else
        # Print just the current directory name for normal folders
        echo -n (basename $PWD)
    end

    # Display the end of the prompt symbol
    set_color --bold brgreen
    echo -n ":"
    echo -n ' '

    set_color normal
end
