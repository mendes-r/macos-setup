#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DIR/lib/common.sh"

echo "== tmux config =="
ensure_symlink "$DIR/files/tmux.conf" "$HOME/.tmux.conf"
