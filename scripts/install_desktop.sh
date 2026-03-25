#!/usr/bin/env bash
set -eu

# Skip on CI unless DOTFILES_DESKTOP=1
if [ -n "${CI:-}" ] && [ "${DOTFILES_DESKTOP:-}" != "1" ]; then
    echo "  skip desktop apps (CI detected, set DOTFILES_DESKTOP=1 to override)"
    exit 0
fi

# Install fonts (Cascadia Code NF for ghostty + starship icons)
install_fonts() {
    local font_dir
    case "$(uname -s)" in
        Darwin) font_dir="$HOME/Library/Fonts" ;;
        Linux)  font_dir="$HOME/.local/share/fonts" ;;
        *)      echo "  skip fonts (unsupported OS)"; return ;;
    esac

    mkdir -p "$font_dir"

    # Cascadia Code (includes Nerd Font variant)
    if ls "$font_dir"/CascadiaCode*.ttf &>/dev/null; then
        echo "  skip cascadia code (already installed)"
    else
        echo "  installing Cascadia Code NF..."
        local tmpdir version
        tmpdir=$(mktemp -d)
        version=$(curl -fsSI https://github.com/microsoft/cascadia-code/releases/latest \
            | grep -i '^location:' | sed 's|.*/v||' | tr -d '[:space:]')
        curl -fsSL -o "$tmpdir/cascadia.zip" \
            "https://github.com/microsoft/cascadia-code/releases/download/v${version}/CascadiaCode-${version}.zip"
        unzip -qo "$tmpdir/cascadia.zip" -d "$tmpdir/cascadia"
        cp "$tmpdir"/cascadia/ttf/*.ttf "$font_dir/"
        rm -rf "$tmpdir"
        if [ "$(uname -s)" = "Linux" ]; then fc-cache -f; fi
        echo "  done."
    fi

    # FiraCode Nerd Font
    if ls "$font_dir"/FiraCode*.ttf &>/dev/null; then
        echo "  skip fira code (already installed)"
    else
        echo "  installing FiraCode Nerd Font..."
        local tmpdir
        tmpdir=$(mktemp -d)
        curl -fsSL -o "$tmpdir/firacode.zip" \
            "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
        unzip -qo "$tmpdir/firacode.zip" -d "$tmpdir/firacode"
        cp "$tmpdir"/firacode/*.ttf "$font_dir/" 2>/dev/null || true
        rm -rf "$tmpdir"
        if [ "$(uname -s)" = "Linux" ]; then fc-cache -f; fi
        echo "  done."
    fi
}

# Install Ghostty
install_ghostty() {
    if command -v ghostty &>/dev/null || [ -d "/Applications/Ghostty.app" ]; then
        echo "  skip ghostty (already installed)"
        return
    fi

    case "$(uname -s)" in
        Darwin)
            echo "  installing ghostty..."
            local tmpdir version
            tmpdir=$(mktemp -d)
            version=$(curl -fsSL https://release.files.ghostty.org/appcast.xml \
                | grep -o '<sparkle:shortVersionString>[^<]*' | tail -1 | sed 's/<[^>]*>//')
            curl -fsSL -o "$tmpdir/Ghostty.dmg" "https://release.files.ghostty.org/${version}/Ghostty.dmg"
            hdiutil attach "$tmpdir/Ghostty.dmg" -quiet -mountpoint "$tmpdir/mnt"
            cp -R "$tmpdir/mnt/Ghostty.app" /Applications/
            hdiutil detach "$tmpdir/mnt" -quiet
            rm -rf "$tmpdir"
            echo "  done."
            ;;
        Linux)
            if [ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]; then
                echo "  installing ghostty via community script..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
            else
                echo "  skip ghostty (no display detected)"
            fi
            ;;
    esac
}

install_fonts
install_ghostty
