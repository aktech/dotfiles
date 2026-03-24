#!/usr/bin/env sh
set -eu

REPO="https://github.com/aktech/dotfiles.git"
DOTFILES_DIR="$HOME/dev/dotfiles"

echo "==> Installing dotfiles"

# Ensure curl is available (needed to install pixi)
if ! command -v curl >/dev/null 2>&1; then
    echo "==> Installing curl..."
    if command -v apt-get >/dev/null 2>&1; then
        apt-get update && apt-get install -y curl
    elif command -v dnf >/dev/null 2>&1; then
        dnf install -y curl
    elif command -v yum >/dev/null 2>&1; then
        yum install -y curl
    elif command -v pacman >/dev/null 2>&1; then
        pacman -Sy --noconfirm curl
    elif command -v apk >/dev/null 2>&1; then
        apk add --no-cache curl
    else
        echo "Error: could not install curl. Install it manually and re-run."
        exit 1
    fi
fi

# Install pixi if not available
if ! command -v pixi >/dev/null 2>&1; then
    echo "==> Installing pixi..."
    curl -fsSL https://pixi.sh/install.sh | sh
    export PATH="$HOME/.pixi/bin:$PATH"
fi

# Install git via pixi if not available
if ! command -v git >/dev/null 2>&1; then
    echo "==> Installing git via pixi..."
    pixi global install git
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

echo "==> Done! Restart your shell or run: cd $DOTFILES_DIR && pixi run zsh"
