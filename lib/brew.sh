#!/usr/bin/env bash
set -euo pipefail

[[ -n "${BREW_SH_INCLUDED:-}" ]] && return
BREW_SH_INCLUDED=1

source "$DOTFILES_ROOT/lib/log.sh"

ensure_homebrew() {
  if ! command -v /opt/homebrew/bin/brew >/dev/null; then
    info "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

brew_install() {
  ensure_homebrew
  for pkg in "$@"; do
    if /opt/homebrew/bin/brew list "$pkg" &>/dev/null; then
      warn "Package $pkg already installed, skipping"
    else
      info "Installing package $pkg..."
      /opt/homebrew/bin/brew install "$pkg"
    fi
  done
}

brew_uninstall() {
  ensure_homebrew
  for pkg in "$@"; do
    if /opt/homebrew/bin/brew list "$pkg" &>/dev/null; then
      info "Uninstalling package $pkg..."
      /opt/homebrew/bin/brew uninstall --ignore-dependencies "$pkg"
    else
      warn "Package $pkg not installed, skipping"
    fi
  done
}
