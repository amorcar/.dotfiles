function fish_user_key_bindings
  # Execute this once per mode that emacs bindings should be used in
  # fish_default_key_bindings -M insert
  # Without an argument, fish_vi_key_bindings will default to
  # resetting all bindings.
  # The argument specifies the initial mode (insert, "default" or visual).
  # fish_vi_key_bindings insert

  fzf_key_bindings


  # Shell only exists after the 5th consecutive Ctrl-d
  # bind \cd delete-char
  # bind \cd\cd\cd\cd\cd exit

end
