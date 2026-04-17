#!/bin/bash
# Bootstrap script for dotfiles.
# Usage: git clone https://github.com/amorcar/.dotfiles.git ~/.dotfiles && cd ~/.dotfiles && sh install.sh
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

echo "==> Installing dotfiles from $DOTFILES_DIR"

# 1. Install Homebrew (macOS)
if [ "$(uname -s)" = "Darwin" ]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "==> Homebrew already installed"
  fi

  # 2. Install packages from Brewfile
  echo "==> Installing Homebrew packages..."
  brew bundle install --file=mac/Brewfile --no-lock
else
  echo "==> Not macOS, skipping Homebrew"
  echo "==> Make sure git, fish, nvim, tmux, fzf, fd, eza, ripgrep are installed"
fi

# 3. Install dotter
if [ ! -f "$DOTFILES_DIR/dotter" ]; then
  echo "==> Installing dotter..."
  DOTTER_VERSION="v0.13.3"
  if [ "$(uname -s)" = "Darwin" ]; then
    ARCH=$(uname -m)
    if [ "$ARCH" = "arm64" ]; then
      DOTTER_URL="https://github.com/SuperCuber/dotter/releases/download/${DOTTER_VERSION}/dotter-armv7-apple-darwin"
    else
      DOTTER_URL="https://github.com/SuperCuber/dotter/releases/download/${DOTTER_VERSION}/dotter-x86_64-apple-darwin"
    fi
  else
    DOTTER_URL="https://github.com/SuperCuber/dotter/releases/download/${DOTTER_VERSION}/dotter-x86_64-unknown-linux-gnu"
  fi
  curl -fsSL "$DOTTER_URL" -o dotter
  chmod +x dotter
else
  echo "==> Dotter already present"
fi

# 4. Create local.toml from template if not exists
if [ ! -f ".dotter/local.toml" ]; then
  echo "==> Creating .dotter/local.toml from template"
  cp .dotter/template_local.toml .dotter/local.toml
  echo "    Edit .dotter/local.toml to select packages, then re-run ./dotter deploy -v"
fi

# 5. Deploy dotfiles via dotter
echo "==> Deploying dotfiles..."
./dotter deploy -v

# 6. Set up fish shell
if command -v fish >/dev/null 2>&1; then
  FISH_PATH=$(command -v fish)
  if ! grep -q "$FISH_PATH" /etc/shells 2>/dev/null; then
    echo "==> Adding fish to /etc/shells (requires sudo)..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "==> Setting fish as default shell..."
    chsh -s "$FISH_PATH"
  else
    echo "==> Fish already default shell"
  fi
else
  echo "==> Fish not found, skipping shell setup"
fi

# 7. Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "==> TPM already installed"
fi

# 8. Install nvim plugins (vim.pack auto-installs on first launch)
if command -v nvim >/dev/null 2>&1; then
  echo "==> Launching nvim to install plugins..."
  nvim --headless -c 'quitall' 2>/dev/null || true
  echo "==> Nvim plugins installed"
else
  echo "==> Nvim not found, skipping plugin install"
fi

echo ""
echo "==> Done! Next steps:"
echo "    1. Review .dotter/local.toml and add/remove packages as needed"
echo "    2. Open tmux and press prefix + I to install tmux plugins"
echo "    3. Open nvim — plugins are auto-installed by vim.pack"
echo "    4. Run :lua require('fff.download').download_or_build_binary() in nvim for fff.nvim"
