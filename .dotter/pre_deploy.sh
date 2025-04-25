#!/bin/bash
echo "[INFO] running pre-deploy script"

if [ "$(uname -s)" = "Darwin" ]; then
  # if homebrew not installed, install it
  if hash brew 2>/dev/null; then
    echo '[INFO] homebrew already installed'
  else
    echo '[INFO] homebrew not found. Installing...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  {{#if dotter.packages.homebrew}}
    echo '[INFO] installing packages in the Brewfile'
    brew bundle install --file ./mac/Brewfile
  {{/if}}
fi

echo "[INFO] pre-deploy script done"
