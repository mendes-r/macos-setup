#!/usr/bin/env zsh
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$DIR/lib/common.sh"

echo "== Neovim config =="
force_symlink "$DIR/files/nvim" "$HOME/.config/nvim"
echo "Note: lazy.nvim plugins will install on first nvim launch"
