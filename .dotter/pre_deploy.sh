
# if homebrew not installed, install it
if hash brew 2>/dev/null; then
  echo 'homebrew already installed'
else
	echo 'homebrew not found. Installing...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install packages in Brewfile
echo 'installing packages in the Brewfile'
brew bundle install --file ./Brewfile
