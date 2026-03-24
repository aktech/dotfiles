# Dotfiles

My dotfiles, managed with [pixi](https://pixi.sh).

## Quick install

**macOS** (curl is built-in):
```sh
curl -fsSL https://iamit.in/install.sh | sh
```

**Linux** (vanilla systems need curl first):
```sh
apt-get update && apt-get install -y curl && curl -fsSL https://iamit.in/install.sh | sh
```

## What it does

1. Installs [pixi](https://pixi.sh) (if not present)
2. Installs git via pixi (if not present)
3. Clones this repo to `~/dev/dotfiles`
4. Installs all tools (neovim, tmux, zsh, starship, etc.) via pixi
5. Installs oh-my-zsh
6. Symlinks configs from `home/` into `$HOME` (existing files are backed up as `.bak`)

## Manual setup

```sh
git clone git@github.com:aktech/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
pixi run setup
```

## Testing

```sh
# Run tests locally
pixi run test

# Test in a clean Linux container
pixi run test-docker
```
