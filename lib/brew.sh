#!/usr/bin/env zsh
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$DIR/lib/common.sh"

echo "== Homebrew =="

BREW_BIN=""
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_BIN=/opt/homebrew/bin/brew
elif [[ -x /usr/local/bin/brew ]]; then
  BREW_BIN=/usr/local/bin/brew
fi

if ! command -v brew >/dev/null 2>&1 && [[ -z "$BREW_BIN" ]]; then
  info "installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    BREW_BIN=/opt/homebrew/bin/brew
  elif [[ -x /usr/local/bin/brew ]]; then
    BREW_BIN=/usr/local/bin/brew
  fi
else
  skip "Homebrew already installed"
fi

# Make sure this script's own process can see `brew` regardless of whether
# it was just installed or already present but missing from PATH.
if [[ -n "$BREW_BIN" ]]; then
  eval "$("$BREW_BIN" shellenv)"
fi

# Persist Homebrew's PATH setup for future shells. Homebrew's installer only
# does this automatically on a fresh install; if brew was already installed
# without it (e.g. installed manually, or ~/.zprofile got recreated), new
# terminals won't find brewed binaries like nvim/tmux. Safe to re-run: only
# added once via the marker block.
if [[ -n "$BREW_BIN" ]]; then
  SHELLENV_SNIPPET="$(mktemp)"
  printf 'eval "$(%s shellenv)"\n' "$BREW_BIN" > "$SHELLENV_SNIPPET"
  append_block_once "$HOME/.zprofile" "homebrew shellenv" "$SHELLENV_SNIPPET"
  rm -f "$SHELLENV_SNIPPET"
fi

info "installing packages from Brewfile (brew bundle never removes unrelated software)"
brew bundle --file="$DIR/Brewfile"
