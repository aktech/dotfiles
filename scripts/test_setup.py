"""Verify dotfiles setup is working correctly."""

import shutil
import subprocess
import sys
from pathlib import Path

DOTFILES_HOME = Path(__file__).resolve().parent.parent / "home"
TARGET_HOME = Path.home()

REQUIRED_TOOLS = ["git", "tmux", "nvim", "starship", "wget", "htop", "curl", "tree"]

errors = []


def check(name: str, ok: bool, msg: str = "") -> None:
    if ok:
        print(f"  PASS  {name}")
    else:
        print(f"  FAIL  {name}: {msg}")
        errors.append(name)


def check_tools() -> None:
    print("Checking tools are available...")
    for tool in REQUIRED_TOOLS:
        path = shutil.which(tool)
        check(tool, path is not None, "not found in PATH")


def check_symlinks() -> None:
    print("\nChecking symlinks...")
    for src in sorted(DOTFILES_HOME.rglob("*")):
        if src.is_dir():
            continue
        rel = src.relative_to(DOTFILES_HOME)
        dst = TARGET_HOME / rel
        is_linked = dst.is_symlink() and dst.resolve() == src.resolve()
        check(str(rel), is_linked, f"expected symlink to {src}")


def check_tools_work() -> None:
    print("\nChecking tools execute...")
    for tool, args in [
        ("git", ["--version"]),
        ("tmux", ["-V"]),
        ("nvim", ["--version"]),
        ("starship", ["--version"]),
    ]:
        try:
            result = subprocess.run(
                [tool, *args], capture_output=True, text=True, timeout=10
            )
            check(f"{tool} runs", result.returncode == 0, result.stderr.strip())
        except Exception as e:
            check(f"{tool} runs", False, str(e))


def main() -> None:
    check_tools()
    check_symlinks()
    check_tools_work()

    print(f"\n{'=' * 40}")
    if errors:
        print(f"FAILED: {len(errors)} check(s)")
        sys.exit(1)
    else:
        print("All checks passed.")


if __name__ == "__main__":
    main()
