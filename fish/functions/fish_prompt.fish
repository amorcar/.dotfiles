# This function is run every time fish displays a new prompt.
function fish_prompt

  set vimModeLen 2 # appears at beginning of prompt (described later)
  set remaining (math "$COLUMNS - $vimModeLen")

  # this info is now in the right prompt
  # git_prompt
  # virtualenv_prompt

  # prompt like [amorales@~]>
  # set_color normal
  # echo -n [
  # set_color --bold brblue # pwd color
  # echo -n (whoami)
  # set_color normal
  # echo -n @

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
  set_color normal
  echo -n ">"
  set_color brgreen
  echo -n ">"
  set_color --bold brgreen
  echo -n ">"

  # prompt like [amorales@~]>
  # set_color normal
  # echo -n "]>"
  echo -n ' ' # space between PWD and branch name

  set_color normal
end
