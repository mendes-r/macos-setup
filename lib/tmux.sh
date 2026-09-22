#!/usr/bin/env zsh
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$DIR/lib/common.sh"

echo "== tmux config =="
force_symlink "$DIR/files/tmux.conf" "$HOME/.tmux.conf"
