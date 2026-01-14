#!/usr/bin/env bash
set -euo pipefail

[[ -n "${PKGMGR_SH_INCLUDED:-}" ]] && return
PKGMGR_SH_INCLUDED=1

source "$DOTFILES_ROOT/lib/log.sh"
source "$DOTFILES_ROOT/lib/brew.sh"

detect_package_manager() {
  OS_TYPE=$(uname | tr '[:upper:]' '[:lower:]')
  case "$OS_TYPE" in
  darwin) 
    echo "brew"
    ;;
  *)
    echo "unknown"
    ;;
  esac
}

pkg_install() {
  local packages=("$@")
  local mgr
  mgr=$(detect_package_manager)

  case "$mgr" in
  brew)
    brew_install "${packages[@]}"
    ;;
  *)
    warn "Unknown package manager, cannot install packages"
    ;;
  esac
}

pkg_uninstall() {
  local packages=("$@")
  local mgr
  mgr=$(detect_package_manager)

  case "$mgr" in
  brew)
    brew_uninstall "${packages[@]}"
    ;;
  *)
    warn "Unknown package manager, cannot uninstall packages"
    ;;
  esac
}
