#!/usr/bin/env zsh
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$DIR/lib/common.sh"

echo "== Git aliases =="

while IFS='=' read -r name value; do
  [[ -z "$name" || "$name" == \#* ]] && continue
  if git config --global --get "alias.${name}" >/dev/null 2>&1; then
    skip "git alias '${name}' already set (kept your existing value)"
  else
    git config --global "alias.${name}" "$value"
    ok "added git alias '${name}' = ${value}"
  fi
done < "$DIR/files/git-aliases.conf"

# Sane, non-destructive global defaults — only set if missing.
set_default() {
  local key="$1" value="$2"
  if git config --global --get "$key" >/dev/null 2>&1; then
    skip "git config '${key}' already set"
  else
    git config --global "$key" "$value"
    ok "set git config '${key}' = ${value}"
  fi
}

set_default core.editor "nvim"
set_default pull.rebase "false"
set_default help.autocorrect "1"
