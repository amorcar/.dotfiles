function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        set_color normal
        echo -n [(basename $VIRTUAL_ENV)]
        set_color normal
    end
end
