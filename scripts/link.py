"""Symlink dotfiles from home/ into $HOME."""

from pathlib import Path

DOTFILES_HOME = Path(__file__).resolve().parent.parent / "home"
TARGET_HOME = Path.home()


def backup(dst: Path) -> None:
    backup_path = dst.with_suffix(dst.suffix + ".bak")
    # If .bak already exists, use numbered suffix
    counter = 1
    while backup_path.exists() or backup_path.is_symlink():
        backup_path = dst.with_suffix(f"{dst.suffix}.bak.{counter}")
        counter += 1
    print(f"  backup {dst} -> {backup_path}")
    dst.rename(backup_path)


def link_recursive(src_dir: Path, dst_dir: Path) -> None:
    for src in sorted(src_dir.iterdir()):
        dst = dst_dir / src.name

        # If source is a symlink or file, link it directly
        # (symlinked dirs like .config/nvim should be linked, not recursed into)
        if src.is_symlink() or src.is_file():
            if dst.is_symlink() or dst.exists():
                if dst.is_symlink() and dst.resolve() == src.resolve():
                    print(f"  skip {dst} (already linked)")
                    continue
                backup(dst)
            dst.symlink_to(src)
            print(f"  link {dst} -> {src}")
        elif src.is_dir():
            dst.mkdir(parents=True, exist_ok=True)
            link_recursive(src, dst)


def main() -> None:
    print(f"Linking dotfiles from {DOTFILES_HOME} into {TARGET_HOME}\n")
    link_recursive(DOTFILES_HOME, TARGET_HOME)
    print("\nDone.")


if __name__ == "__main__":
    main()
