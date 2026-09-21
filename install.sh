#!/usr/bin/env bash
# macos-setup — bootstrap neovim, tmux, zsh aliases/prompt, and git aliases
# on a macOS machine.
#
# Safe to re-run: every step only fills in what's missing. It never
# overwrites an existing ~/.zshrc alias, an existing git alias, or an
# existing ~/.tmux.conf / ~/.config/nvim — those are left exactly as they
# are, with a note printed instead.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "macos-setup"
echo "==========="
echo "This will install Homebrew packages and link/merge dotfiles."
echo "Existing configs are never overwritten — see README.md for details."
echo

bash "$DIR/lib/brew.sh"
echo
bash "$DIR/lib/neovim.sh"
echo
bash "$DIR/lib/tmux.sh"
echo
bash "$DIR/lib/zsh.sh"
echo
bash "$DIR/lib/git.sh"
echo

echo "Done. Open a new terminal (or run 'source ~/.zshrc') to pick up changes."
