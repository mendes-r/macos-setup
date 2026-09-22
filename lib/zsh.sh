#!/usr/bin/env zsh
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$DIR/lib/common.sh"

ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

echo "== zsh aliases =="

missing_aliases="$(mktemp)"
trap 'rm -f "$missing_aliases"' EXIT

while IFS= read -r line; do
  # only look at actual "alias name=" lines; comments/blanks pass through
  if [[ "$line" =~ ^alias[[:space:]]+([a-zA-Z0-9_.]+)= ]]; then
    name="${match[1]}"
    if has_alias_named "$ZSHRC" "$name"; then
      skip "alias '${name}' already defined in .zshrc (kept your existing one)"
      continue
    fi
  fi
  echo "$line" >> "$missing_aliases"
done < "$DIR/files/aliases.zsh"

if [[ -s "$missing_aliases" ]] && grep -q '^alias ' "$missing_aliases"; then
  append_block_once "$ZSHRC" "aliases" "$missing_aliases"
else
  skip "no new aliases to add"
fi

echo "== zsh prompt =="

if grep -qE '(vcs_info|starship init|PROMPT_SUBST)' "$ZSHRC" 2>/dev/null; then
  skip "a git-aware prompt already seems configured in .zshrc"
else
  append_block_once "$ZSHRC" "prompt" "$DIR/files/prompt.zsh"
fi
