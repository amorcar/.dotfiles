#!/bin/bash
echo "[INFO] running post-deploy script"

BIN_DIR="$HOME/.local/bin"

if [ ! -d "$BIN_DIR" ]; then
    echo "[INFO] $BIN_DIR does not exist"
else
  find "$BIN_DIR" -type f -o -type l -exec chmod +x {} \;
  echo "[INFO] all files in $BIN_DIR are now executable"
fi

{{#if dotter.packages.homebrew}}
  if [ "$(uname -s)" = "Darwin" ]; then
    # if homebrew is available
    if hash brew 2>/dev/null; then
      echo '[INFO] installing packages in the Brewfile'
      brew bundle install --file ./mac/Brewfile
    fi
  else
    echo '[INFO] homebrew package active in non-macos machine'
  fi
{{/if}}

echo "[INFO] post-deploy script done"
