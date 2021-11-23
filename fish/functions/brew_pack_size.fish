function brew_pack_size
  brew list | xargs brew info | grep Cellar
end
