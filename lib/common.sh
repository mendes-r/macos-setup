#!/usr/bin/env zsh
# Shared helpers for macos-setup installers.
# Guiding rule: never overwrite or delete ~/.zshrc / git config settings the
# user already has. tmux and nvim configs are always replaced with the
# bundled versions (existing ones are backed up first).

info()  { printf '  \033[36m→\033[0m %s\n' "$1"; }
ok()    { printf '  \033[32m✓\033[0m %s\n' "$1"; }
warn()  { printf '  \033[33m!\033[0m %s\n' "$1"; }
skip()  { printf '  \033[90m·\033[0m %s (skipped)\n' "$1"; }

# backup_once <path>
# Copies <path> to <path>.macos-setup.bak.<timestamp> if it exists and no
# backup has been made yet in this run. Safe to call before any risky edit.
backup_once() {
  local target_path="$1"
  if [[ -e "$target_path" && ! -L "$target_path" ]]; then
    local backup="${target_path}.macos-setup.bak.$(date +%Y%m%d%H%M%S)"
    cp -R "$target_path" "$backup"
    warn "backed up existing $target_path -> $backup"
  fi
}

# ensure_symlink <source> <link_path>
# Creates a symlink only if link_path does not already exist. If it exists
# as a real file/dir (not already our symlink), it is left untouched.
ensure_symlink() {
  local source="$1"
  local link_path="$2"

  if [[ -L "$link_path" ]]; then
    if [[ "$(readlink "$link_path")" == "$source" ]]; then
      skip "$link_path already linked to $source"
      return 0
    else
      warn "$link_path is a symlink to something else — leaving it alone"
      return 0
    fi
  fi

  if [[ -e "$link_path" ]]; then
    warn "$link_path already exists and is not our symlink — leaving it alone"
    warn "  (bundled version available at $source if you want to merge manually)"
    return 0
  fi

  mkdir -p "$(dirname "$link_path")"
  ln -s "$source" "$link_path"
  ok "linked $link_path -> $source"
}

# force_symlink <source> <link_path>
# Like ensure_symlink, but if link_path already exists as a real file/dir
# (not our symlink), it is backed up (via backup_once) and replaced with a
# symlink to source. Used for configs we're happy to overwrite (nvim, tmux),
# as opposed to ~/.zshrc which is always merged, never replaced.
force_symlink() {
  local source="$1"
  local link_path="$2"

  if [[ -L "$link_path" ]]; then
    if [[ "$(readlink "$link_path")" == "$source" ]]; then
      skip "$link_path already linked to $source"
      return 0
    else
      warn "$link_path is a symlink to something else — replacing it"
      rm -f "$link_path"
    fi
  elif [[ -e "$link_path" ]]; then
    backup_once "$link_path"
    rm -rf "$link_path"
  fi

  mkdir -p "$(dirname "$link_path")"
  ln -s "$source" "$link_path"
  ok "linked $link_path -> $source"
}

# append_block_once <file> <marker_name> <content_file>
# Appends content_file into file, wrapped in a marker comment block, but
# only if that marker isn't already present. Never touches existing lines.
append_block_once() {
  local file="$1"
  local marker="$2"
  local content_file="$3"
  local begin="# >>> macos-setup: ${marker} >>>"
  local end="# <<< macos-setup: ${marker} <<<"

  touch "$file"
  if grep -qF "$begin" "$file" 2>/dev/null; then
    skip "$marker block already present in $file"
    return 0
  fi

  {
    printf '\n%s\n' "$begin"
    cat "$content_file"
    printf '%s\n' "$end"
  } >> "$file"
  ok "added $marker block to $file"
}

# has_alias_named <zshrc_file> <alias_name>
has_alias_named() {
  local file="$1" name="$2"
  grep -qE "^[[:space:]]*alias[[:space:]]+${name}=" "$file" 2>/dev/null
}
