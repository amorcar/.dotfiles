function prompt_vim_mode -d 'Vi mode status indicator'
  if test "$fish_key_bindings" = 'fish_vi_key_bindings'
    switch $fish_bind_mode
      case default
        set_color red
        echo N
        echo ' '
      case insert
        set_color green
        # echo I
        # echo ' '
      case replace_one # There is no replace_all.
        set_color green
        echo R
        echo ' '
      case visual
        set_color magenta
        echo V
        echo ' '
    end
  end
end
