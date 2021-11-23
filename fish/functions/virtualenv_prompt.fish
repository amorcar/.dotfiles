function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        # printf ' inside '
        set_color normal
        #printf '(%s)' (basename "$VIRTUAL_ENV")
        echo -n [(basename $VIRTUAL_ENV)]
        set_color normal
    end
end
