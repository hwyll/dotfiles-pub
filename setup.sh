#!/usr/bin/env bash
set -euo pipefail

# -------------------------
# Paths
# -------------------------
DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
CONFIG_DIR="$DOTFILES_ROOT/config"
PACKAGES_DIR="$DOTFILES_ROOT/packages"

# -------------------------
# Imports
# -------------------------
source "$DOTFILES_ROOT/lib/log.sh"
source "$DOTFILES_ROOT/lib/util.sh"
source "$DOTFILES_ROOT/lib/stow.sh"
source "$DOTFILES_ROOT/lib/pkgmgr.sh"
source "$DOTFILES_ROOT/lib/zsh.sh"

# -------------------------
# Usage
# -------------------------
usage() {
  echo "Usage: $0 [--install | --uninstall]"
  exit 1
}
[[ $# -eq 1 ]] || usage
ACTION="$1"

# -------------------------
# Load packages
# -------------------------
COMMON_PACKAGES="$(read_list "$PACKAGES_DIR/common.txt")"

OS_TYPE=$(uname | tr '[:upper:]' '[:lower:]')
case "$OS_TYPE" in
darwin) OS_PACKAGES="$(read_list "$PACKAGES_DIR/macos.txt")" ;;
*)
  warn "Unknown OS: $OS_TYPE"
  OS_PACKAGES=""
  ;;
esac

ALL_PACKAGES="$(deduplicate_array $COMMON_PACKAGES $OS_PACKAGES)"
PACKAGES_ARRAY=($ALL_PACKAGES)

# -------------------------
# Load zsh plugins
# -------------------------
ZSH_PLUGINS="$(read_zsh_plugins "$PACKAGES_DIR/zsh-plugins.txt")"
ZSH_PLUGINS="$(deduplicate_array $ZSH_PLUGINS)"
ZSH_PLUGINS_ARRAY=($ZSH_PLUGINS)

# -------------------------
# Install
# -------------------------
install() {
  info "Installing dotfiles..."
  pkg_install "${PACKAGES_ARRAY[@]}"
  stow_all "$CONFIG_DIR" "$HOME"
  install_oh_my_zsh
  install_zsh_plugins "${ZSH_PLUGINS_ARRAY[@]}" # requires git
  info "Installed dotfiles."
}

# -------------------------
# Uninstall
# -------------------------
uninstall() {
  info "Uninstalling dotfiles..."
  unstow_all "$CONFIG_DIR" "$HOME"
  pkg_uninstall "${PACKAGES_ARRAY[@]}"
  uninstall_zsh_plugins
  uninstall_oh_my_zsh
  info "Uninstalled dotfiles."
}

# -------------------------
# Main
# -------------------------
case "$ACTION" in
--install) install ;;
--uninstall) uninstall ;;
*) usage ;;
esac
