# Dotfiles

My dotfiles, managed with [pixi](https://pixi.sh).

## Setup on a new machine

```sh
# Clone
git clone git@github.com:aktech/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles

# Install tools + symlink dotfiles
pixi run setup
```

This will:
1. Install all tools (neovim, tmux, starship, etc.) into the pixi environment
2. Symlink configs from `home/` into `$HOME` (existing files are backed up as `.bak`)
