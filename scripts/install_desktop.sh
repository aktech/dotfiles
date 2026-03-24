#!/usr/bin/env bash
set -eu

# Skip on headless/CI systems
if [ -n "${CI:-}" ]; then
    echo "  skip desktop apps (CI detected)"
    exit 0
fi

# Install Ghostty
install_ghostty() {
    if command -v ghostty &>/dev/null || [ -d "/Applications/Ghostty.app" ]; then
        echo "  skip ghostty (already installed)"
        return
    fi

    case "$(uname -s)" in
        Darwin)
            if command -v brew &>/dev/null; then
                echo "  installing ghostty via homebrew..."
                brew install --cask ghostty
            else
                echo "  skip ghostty (homebrew not found, install manually from https://ghostty.org)"
            fi
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

install_ghostty
