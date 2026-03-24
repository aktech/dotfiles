"""Symlink dotfiles from home/ into $HOME."""

import os
from pathlib import Path

DOTFILES_HOME = Path(__file__).resolve().parent.parent / "home"
TARGET_HOME = Path.home()


def link_recursive(src_dir: Path, dst_dir: Path) -> None:
    for src in sorted(src_dir.iterdir()):
        dst = dst_dir / src.name
        if src.is_dir():
            dst.mkdir(parents=True, exist_ok=True)
            link_recursive(src, dst)
        else:
            if dst.is_symlink() or dst.exists():
                if dst.is_symlink() and dst.resolve() == src.resolve():
                    print(f"  skip {dst} (already linked)")
                    continue
                backup = dst.with_suffix(dst.suffix + ".bak")
                print(f"  backup {dst} -> {backup}")
                dst.rename(backup)
            dst.symlink_to(src)
            print(f"  link {dst} -> {src}")


def main() -> None:
    print(f"Linking dotfiles from {DOTFILES_HOME} into {TARGET_HOME}\n")
    link_recursive(DOTFILES_HOME, TARGET_HOME)
    print("\nDone.")


if __name__ == "__main__":
    main()
