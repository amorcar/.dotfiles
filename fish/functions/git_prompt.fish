function git_prompt
    if git rev-parse --show-toplevel >/dev/null 2>&1
        set_color normal
        #printf ' on '
        set_color normal
        printf '[%s]' (git_current_branch)
        #set_color green
        #git_prompt_status
        set_color normal
    end
end
