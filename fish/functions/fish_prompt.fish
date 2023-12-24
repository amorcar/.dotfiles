# This function is run every time fish displays a new prompt.
function fish_prompt

  set vimModeLen 2 # appears at beginning of prompt (described later)
  set remaining (math "$COLUMNS - $vimModeLen")

  # Display the current time
  set time_prompt (date +%H:%M)
  set time_prompt_length (string length time_prompt)
  set reamining (math "$remaining - $time_prompt_length")
  set_color brblack
  echo -n "[$time_prompt] "

  # Display working directory.
  set_color brgreen # pwd color
  set pwdLen (string length $PWD)

  if test $pwdLen -le $remaining
    if test (basename $PWD) != $USER
      echo -n (basename $PWD)
    else
      echo -n (pwd | sed -e "s|^$HOME|~|")
    end
    set remaining (math "$remaining - $pwdLen")
  else
    echo -n (prompt_pwd) # abbreviated working directory
    set remaining 0 # so nothing else is output on this line
  end

  # prompt like >>>
  echo -n ' '
  set_color --bold brgreen
  echo -n ">"

  echo -n ' ' # space between PWD and branch name

  set_color normal
end
