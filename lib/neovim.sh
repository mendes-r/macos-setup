#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DIR/lib/common.sh"

echo "== Neovim config =="
ensure_symlink "$DIR/files/nvim" "$HOME/.config/nvim"
