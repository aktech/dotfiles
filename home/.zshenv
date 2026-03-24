# Workaround: conda-forge zsh doesn't set ZSH_VERSION
[ -z "$ZSH_VERSION" ] && [ -n "$ZSH_PATCHLEVEL" ] && ZSH_VERSION="${ZSH_PATCHLEVEL%%-*}"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
