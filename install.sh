#!/usr/bin/env bash
set -eu

REPO="https://github.com/aktech/dotfiles.git"
DOTFILES_DIR="$HOME/dev/dotfiles"

echo "==> Installing dotfiles"

# Install pixi if not available
if ! command -v pixi &>/dev/null; then
    echo "==> Installing pixi..."
    curl -fsSL https://pixi.sh/install.sh | bash
    export PATH="$HOME/.pixi/bin:$PATH"
fi

# Clone dotfiles
if [ -d "$DOTFILES_DIR" ]; then
    echo "==> Updating dotfiles..."
    git -C "$DOTFILES_DIR" pull
else
    echo "==> Cloning dotfiles..."
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone "$REPO" "$DOTFILES_DIR"
fi

# Run setup
cd "$DOTFILES_DIR"
echo "==> Running setup..."
pixi run setup

echo "==> Done! Restart your shell or run: exec zsh"
