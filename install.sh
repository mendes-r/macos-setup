#!/usr/bin/env zsh
# macos-setup — bootstrap neovim, tmux, zsh aliases/prompt, and git aliases
# on a macOS machine.
#
# Safe to re-run: every step only fills in what's missing for zsh/git config.
# It never overwrites an existing ~/.zshrc alias or an existing git alias —
# those are left exactly as they are, with a note printed instead.
# ~/.tmux.conf and ~/.config/nvim ARE overwritten (with a timestamped backup
# first) so the bundled configs always take effect.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "macos-setup"
echo "==========="
echo "This will install Homebrew packages and link/merge dotfiles."
echo "~/.zshrc and git aliases are never overwritten; ~/.tmux.conf and"
echo "~/.config/nvim are replaced (backed up first) — see README.md for details."
echo

zsh "$DIR/lib/brew.sh"
echo
zsh "$DIR/lib/neovim.sh"
echo
zsh "$DIR/lib/tmux.sh"
echo
zsh "$DIR/lib/zsh.sh"
echo
zsh "$DIR/lib/git.sh"
echo

echo "Done. Open a new terminal (or run 'source ~/.zshrc') to pick up changes."
