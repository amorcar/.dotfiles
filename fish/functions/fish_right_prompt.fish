function fish_right_prompt -d "Write out the right prompt"
    # Capture the exit status of the previous command
    set -l exit_code $status

    # Exit code indicator: red dot for failed commands
    if test $exit_code -ne 0
        set_color red
        echo -n "• "
    end

    set -l git_args --no-optional-locks

    # Fetch all basic Git info in a single call
    set -l git_info (command git $git_args rev-parse --is-inside-work-tree --is-bare-repository --git-dir --git-common-dir 2>/dev/null)

    # If the command succeeded, we are in a Git repo
    if test $status -eq 0
        set -l is_bare $git_info[2]
        set -l git_dir $git_info[3]
        set -l common_dir $git_info[4]
        
        # Detect worktree
        set -l in_worktree false
        # if test "$git_dir" != "$common_dir"
        #     set in_worktree true
        # end

        # 1. BARE REPO CHECK
        if test "$is_bare" = "true"
            set_color --dim brgrey
            echo -n "[b]"
            
        # 2. FAST PATH FOR WORKTREES
        else if test "$in_worktree" = "true"
            # We skip upstream counts and dirty checks to guarantee instant prompts.
            
            # Stash indicator (rev-parse is instant and doesn't traverse files)
            if command git $git_args rev-parse --verify refs/stash >/dev/null 2>&1
                set_color cyan
                echo -n "Ξ"
            end

            # Username indicator
            if test "$USER" != "$LOGNAME"
                set_color green
                echo -n "$USER@"
            end

            # Visual indicator that we are in a worktree (since we skip the branch name)
            set_color --dim brgrey
            echo -n "[w]"

        # 3. FULL FEATURE PATH FOR REGULAR REPOS
        else
            # Upstream comparison
            set -l commit_counts (command git $git_args rev-list --left-right --count 'HEAD...@{upstream}' 2>/dev/null)
            if test $status -eq 0
                set -l counts (string split \t -- $commit_counts)
                set -l commits_to_push $counts[1]
                set -l commits_to_pull $counts[2]

                # Arrow for commits to push (up)
                if test -n "$commits_to_push"; and test "$commits_to_push" -gt 0
                    if test "$commits_to_pull" -gt 0
                        set_color red
                    else if test "$commits_to_push" -gt 3
                        set_color yellow
                    else
                        set_color green
                    end
                    echo -n "⇡ "
                end

                # Arrow for commits to pull (down)
                if test -n "$commits_to_pull"; and test "$commits_to_pull" -gt 0
                    if test "$commits_to_push" -gt 0
                        set_color red
                    else if test "$commits_to_pull" -gt 3
                        set_color yellow
                    else
                        set_color green
                    end
                    echo -n "⇣ "
                end
            end

            # Stash indicator
            if command git $git_args rev-parse --verify refs/stash >/dev/null 2>&1
                set_color cyan
                echo -n "Ξ"
            end

            # Username indicator
            if test "$USER" != "$LOGNAME"
                set_color green
                echo -n "$USER@"
            end

            # Working tree status (dirty/clean)
            command git $git_args diff-files --quiet --ignore-submodules 2>/dev/null
            set -l has_unstaged_files $status

            command git $git_args diff-index --quiet --ignore-submodules --cached HEAD 2>/dev/null
            set -l has_staged_files $status

            # Set color based on git status
            if test $has_unstaged_files -ne 0
                set_color red
            else if test $has_staged_files -ne 0
                set_color yellow
            else
                set_color green
            end

            # Print branch name
            set -l git_branch (command git $git_args symbolic-ref --short HEAD 2>/dev/null)
            if test -n "$git_branch"
                echo -n "[$git_branch]"
            end
        end
    end

    # Reset color to normal before time prompt
    set_color normal

    # Time indicator
    set -l time_prompt (date +%H:%M)
    set_color brgreen
    echo -n "[$time_prompt] "
end
