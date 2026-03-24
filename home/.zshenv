# Workaround: conda-forge zsh doesn't set ZSH_VERSION
[ -z "$ZSH_VERSION" ] && [ -n "$ZSH_PATCHLEVEL" ] && ZSH_VERSION="${ZSH_PATCHLEVEL%%-*}"

# Pixi-managed tools
export PATH="$HOME/.pixi/bin:$PATH"

# Activate pixi project environment if dotfiles exist
if [ -f "$HOME/dev/dotfiles/pyproject.toml" ]; then
    eval "$(pixi shell-hook --manifest-path "$HOME/dev/dotfiles/pyproject.toml" 2>/dev/null)" 2>/dev/null || true
fi

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
