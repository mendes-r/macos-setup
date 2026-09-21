#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DIR/lib/common.sh"

echo "== Homebrew =="

if ! command -v brew >/dev/null 2>&1; then
  info "installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  skip "Homebrew already installed"
fi

info "installing packages from Brewfile (brew bundle never removes unrelated software)"
brew bundle --file="$DIR/Brewfile"
