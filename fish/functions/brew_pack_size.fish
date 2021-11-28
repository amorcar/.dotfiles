function brew_pack_size
  brew list | xargs brew info | grep Cellar | cut -d'/' -f5,6 | sed 's/\/.*\,//' | sed 's/ / - /' | sed 's/...$//'
end
