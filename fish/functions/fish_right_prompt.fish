function fish_right_prompt -d "Write out the right prompt"
  set -l exit_code $status
  set -l is_git_repository (git rev-parse --is-inside-work-tree 2> /dev/null)

  # Print the current directory. Replace $HOME with ~.
  # set_color green
  # echo -n (prompt_pwd | sed -e "s|^$HOME|~|")
  # echo -n " "

# Print vi mode indicator
  # prompt_vim_mode


  # Print a yellow fork symbol when in a subshell
  if set -q TMUX # test -n "$TMUX"
    set_color yellow
    echo -n "⑂ "
  end

  # Print a red dot for failed commands.
  if test $exit_code -ne 0
    set_color red
    echo -n "• "
  end

  # Print coloured arrows when git push (up) and / or git pull (down) can be run.
  #
  # Red means the local branch and the upstream branch have diverted.
  # Yellow means there are more than 3 commits to push or pull.
  if test -n "$is_git_repository"

    set -l has_upstream (git rev-parse --abbrev-ref '@{upstream}' 2> /dev/null)
    # git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null 2>&1; and set -l has_upstream
    if set -q has_upstream
      set -l commit_counts (git rev-list --left-right --count 'HEAD...@{upstream}' 2>/dev/null)

      set -l commits_to_push (echo $commit_counts | cut -f 1 2>/dev/null)
      set -l commits_to_pull (echo $commit_counts | cut -f 2 2>/dev/null)

      if test -n "$commits_to_pull"; and test -n "$commits_to_push"

        if test $commits_to_push != 0
          if test $commits_to_pull -ne 0
            set_color red
          else if test $commits_to_push -gt 3
            set_color yellow
          else
            set_color green
          end

          echo -n "⇡ "
        end

        if test $commits_to_pull != 0
          if test $commits_to_push -ne 0
            set_color red
          else if test $commits_to_pull -gt 3
            set_color yellow
          else
            set_color green
          end

          echo -n "⇣ "
        end

    end # end test commits_to_pull and push

    end # end has_upstream

    # Print a "stack symbol" if there are stashed changes.
    if test (git stash list | wc -l) -gt 0
      set_color cyan
      echo -n "☰ "
    end

    # Print the username when the user has been changed.
    if test $USER != $LOGNAME
      set_color green
      echo -n "$USER@"
    end

    git diff-files --quiet --ignore-submodules 2>/dev/null; or set -l has_unstaged_files
    git diff-index --quiet --ignore-submodules --cached HEAD 2>/dev/null; or set -l has_staged_files

    if set -q has_unstaged_files
      set_color red
    else if set -q has_staged_files
      set_color yellow
    else
      set_color green
    end

    echo -n "["
    set -l git_branch (git branch 2>/dev/null | sed -n '/\* /s///p')
    echo -n $git_branch
    echo -n "]"

  end # end is_git_repository
  set_color normal

  # Print the current git branch name or shortened commit hash in colour.
  #
  # Green means the working directory is clean.
  # Yellow means all changed files have been staged.
  # Red means there are changed files that are not yet staged.
  #
  # Untracked files are ignored.
  # if test -n "$is_git_repository"

  #   git diff-files --quiet --ignore-submodules 2>/dev/null; or set -l has_unstaged_files
  #   git diff-index --quiet --ignore-submodules --cached HEAD 2>/dev/null; or set -l has_staged_files

  #   if set -q has_unstaged_files
  #     set_color red
  #   else if set -q has_staged_files
  #     set_color yellow
  #   else
  #     set_color green
  #   end

  #   echo -n "["
  #   set -l git_branch (git branch 2>/dev/null | sed -n '/\* /s///p')
  #   echo -n $git_branch
  #   echo -n "]"


  #   set_color black
  # end

  # set_color normal
end
