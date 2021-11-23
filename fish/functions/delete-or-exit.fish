function delete-or-exit -d 'Customize ctrl-D behavior to ask for confirmation'
    set -l cmd (commandline)
    switch "$cmd"
        case ''
            read --nchars 1 --local -P 'Do you want to exit? [y/N] ' confirm
            switch $confirm
                case Y y
                    exit 0
                case '' N n
                    echo -n (fish_prompt)
            end
        case '*'
            commandline -f delete-char
    end
end
