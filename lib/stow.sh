#!/usr/bin/env bash
set -euo pipefail

[[ -n "${STOW_SH_INCLUDED:-}" ]] && return
STOW_SH_INCLUDED=1

source "$DOTFILES_ROOT/lib/log.sh"

# -------------------------
# Stow all directories in a given folder to target
# Usage: stow_all <source_dir> <target_dir>
# -------------------------
stow_all() {
  local src="$1"
  local target="$2"
  for dir in "$src"/*/; do
    [[ -d "$dir" ]] || continue
    local pkg="$(basename "$dir")"
    info "Stowing $pkg..."
    /opt/homebrew/bin/stow -t "$target" -d "$src" "$pkg"
  done
}

# -------------------------
# Unstow all directories in a given folder from target
# Usage: unstow_all <source_dir> <target_dir>
# -------------------------
unstow_all() {
  local src="$1"
  local target="$2"
  for dir in "$src"/*/; do
    [[ -d "$dir" ]] || continue
    local pkg="$(basename "$dir")"
    info "Unstowing $pkg..."
    /opt/homebrew/bin/stow -D -t "$target" -d "$src" "$pkg"
  done
}
